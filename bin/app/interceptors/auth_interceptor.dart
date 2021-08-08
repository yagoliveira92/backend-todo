import 'package:shelf/shelf.dart';

class AuthMiddleware {
  //static JsonDecoder _decoder = const JsonDecoder();

  static Middleware handle() {
    return createMiddleware(requestHandler: (request) {
      if (request.requestedUri.path != '/login') {
        if (request.headers['token'] == null) {
          return Response(401, body: "Não autorizado!");
        }
      }
      return null;
    });
  }
}
