import 'package:shelf/shelf.dart';

class CorsInterceptor {
  static handler(Request request) {
    return createMiddleware();
  }
}
