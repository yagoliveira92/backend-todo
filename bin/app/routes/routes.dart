import 'package:shelf_router/shelf_router.dart' as shelf_router;

import '../controllers/forecast_controller.dart';
import '../controllers/hello_world_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/sensors_controller.dart';

class Routes {
  static shelf_router.Router routes() {
    final _router = shelf_router.Router()
      ..get(
        '/helloworld',
        HelloWorldController.helloWorldHandler,
      )
      ..post(
        '/login',
        LoginController.loginHandler,
      )
      ..get(
        '/home',
        HomeController.homeHandler,
      )
      ..get(
        '/sensors',
        SensorsController.sensorsHandler,
      )
      ..get(
        '/forecast',
        ForecastController.forecastHandler,
      );
    return _router;
  }
}
