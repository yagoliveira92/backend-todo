import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../config/env_config.dart';
import '../model/user_model.dart';

abstract class JWTController {
  static String generateJwt({required UserModel user}) {
    final jwt = JWT(
      {
        'iat': DateTime.now().millisecondsSinceEpoch.toString(),
      },
      subject: user.id!.toHexString(),
    );
    return jwt.sign(SecretKey(Env.secretKey), expiresIn: Duration(days: 7));
  }

  static dynamic verifyJwt({required String token}) {
    try {
      final tokenVerify = token.substring(7);
      final jwt = JWT.verify(tokenVerify, SecretKey(Env.secretKey));
      return jwt;
    } on JWTExpiredError {
      return JWTError('Token Expirado');
    } on JWTInvalidError {
      return JWTInvalidError('Token Inválido');
    }
  }

  static Future<UserModel?> getUserJWT({required String token}) async {
    final jwtResult = verifyJwt(token: token);
    if (jwtResult is JWT) {
      final db = await Db.create(Env.mongoUrl);
      await db.open();
      final store = db.collection('users');
      final responseStore = await store.findOne(
        where.id(
          (ObjectId.fromHexString(jwtResult.subject ?? '')),
        ),
      );
      db.close();
      if (responseStore != null) {
        final user = UserModel.fromMap(responseStore);
        return user;
      }
    }
    return null;
  }
}
