import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:crypto/crypto.dart';
import '../../../config/env_config.dart';
import '../../model/user_model.dart';

class RegisterController {
  static handle(Request request) async {
    Map<String, dynamic> response = json.decode(await request.readAsString());
    final db = await Db.create(Env.mongoUrl);
    await db.open();
    final store = db.collection('users');
    var hashPassword =
        md5.convert(utf8.encode(response['password']!)).toString();
    UserModel newUser = UserModel(
        name: response['name'],
        email: response['user'],
        password: hashPassword);
    final result = await store.insert(newUser.toMap());
    db.close();
    return Response.ok(
      JsonEncoder.withIndent(' ').convert(result),
    );
  }
}
