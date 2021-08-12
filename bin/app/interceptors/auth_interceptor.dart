import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../core/jwt_controller.dart';

class AuthMiddleware {
  static Middleware handle() {
    return createMiddleware(
      requestHandler: (request) {
        if (request.requestedUri.path == '/login') return null;
        final authHeader = request.headers['authorization'];
        if (authHeader != null && authHeader.startsWith('Bearer ')) {
          var resultVerify = JWTController.verifyJwt(token: authHeader);
          if (resultVerify is JWT) {
            return null;
          }
          if (resultVerify is JWTError) {
            return Response.forbidden(
              JsonEncoder.withIndent(' ').convert(
                {'error': resultVerify.message},
              ),
            );
          }
        }
        return Response.forbidden(
          JsonEncoder.withIndent(' ').convert(
            {'error': 'Credenciais inválidas!'},
          ),
        );
      },
    );
  }
}
