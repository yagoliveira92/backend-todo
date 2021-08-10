import 'package:envify/envify.dart';

part 'env_config.g.dart';

@Envify()
abstract class Env {
  static const secretKey = _Env.secretKey;
  static const mongoUrl = _Env.mongoUrl;
}
