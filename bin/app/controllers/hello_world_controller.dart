import 'package:shelf/shelf.dart';

class HelloWorldController {
  static helloWorldHandler(Request request) => Response.ok('Hello, World!');
}
