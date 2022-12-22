import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:http/http.dart' as http;

class LoginController {
  static loginHandler(Request request) async {
    final url = Uri.https('staging.cultivointeligente.com.br', '/api/v4/auth');
    Map<String, dynamic> response = json.decode(await request.readAsString());
    var result = await http.post(url, body: response);
    return Response(result.statusCode, body: result.body);
  }
}
