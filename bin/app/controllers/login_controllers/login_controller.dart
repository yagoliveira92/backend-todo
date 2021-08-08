import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';

class LoginController {
  static handle(Request request) async {
    Map<String, String> response = request.url.queryParameters;
    if (response.isNotEmpty) {
      final db = await Db.create(
          'mongodb+srv://yagoliveira92:mXZIaStSnUxT0VFV@cluster0.bf9e1.mongodb.net/todoDart?retryWrites=true&w=majority');
      await db.open();
      final store = db.collection('users');
      final user = await store.findOne(where.eq('user', response['user']));
      db.close();
      if (user!['password'] ==
          md5.convert(utf8.encode(response['password']!)).toString()) {
        final jwt = JWT({'id': user['_id']});
        return Response.ok(
          JsonEncoder.withIndent(' ')
              .convert({'token': jwt.sign(SecretKey('apenasumteste'))}),
        );
      }
    }
    return Response(
      401,
      body: JsonEncoder.withIndent(' ')
          .convert({'error': 'Credenciais inválidas!'}),
    );
  }
}
