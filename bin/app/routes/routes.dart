import 'package:shelf_router/shelf_router.dart' as shelf_router;

import '../controllers/hello_world_controller.dart';
import '../controllers/login_controllers/login_controller.dart';
import '../controllers/task_controllers/create_task_controller.dart';

class Routes {
  static shelf_router.Router routes() {
    final _router = shelf_router.Router()
      ..get(
        '/helloworld',
        HelloWorldController.helloWorldHandler,
      )
      ..post(
        '/login',
        LoginController.handle,
      )
      ..post(
        '/create-task',
        CreateTaskController.handle,
      );
    return _router;
  }
}
