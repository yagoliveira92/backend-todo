import 'dart:convert';

import 'package:shelf/shelf.dart';

class HelloWorldController {
  static helloWorldHandler(Request request) async {
     Map<String, dynamic> response = json.decode(await request.readAsString());
    return Response.ok("Olá, ${response['name']}!");
  }
}
