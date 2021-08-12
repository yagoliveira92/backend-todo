import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import '../../../config/env_config.dart';
import '../../core/jwt_controller.dart';
import '../../model/user_model.dart';

class LoginController {
  static handle(Request request) async {
    Map<String, String> response = request.url.queryParameters;
    UserModel user;
    if (response.isNotEmpty) {
      final db = await Db.create(Env.mongoUrl);
      await db.open();
      final store = db.collection('users');
      final responseStore =
          await store.findOne(where.eq('email', response['user']));
      db.close();
      if (responseStore != null) {
        user = UserModel.fromMap(responseStore);
        if (user.password ==
            md5.convert(utf8.encode(response['password']!)).toString()) {
          return Response.ok(
            JsonEncoder.withIndent(' ')
                .convert({'token': JWTController.generateJwt(user: user)}),
          );
        }
      }
    }
    return Response(
      401,
      body: JsonEncoder.withIndent(' ')
          .convert({'error': 'Credenciais inválidas!'}),
    );
  }
}
