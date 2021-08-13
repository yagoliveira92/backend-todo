import 'package:shelf/shelf.dart';

import '../core/jwt_controller.dart';

class HelloWorldController {
  static helloWorldHandler(Request request) async {
    final userId = await JWTController.getUserJWT(request: request);
    return Response.ok("Olá, ${userId!.name}");
  }
}
