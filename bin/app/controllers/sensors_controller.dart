import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:http/http.dart' as http;

import '../models/sensors/sensors_entity.dart';
import '../utils/sensors_calculus.dart';

class SensorsController {
  static sensorsHandler(Request request) async {
    final allParams = request.requestedUri.queryParameters;
    final getToken = request.headers['authorization'] ?? '';

    final urlSensors = Uri.https('staging.cultivointeligente.com.br',
        '/api/v4/widgets/equipment_measures', {
      'organization_id': allParams['organization_id'],
    });

    final resultSensors =
        await http.get(urlSensors, headers: {'authorization': getToken});
    if (resultSensors.statusCode > 300) {
      return Response(resultSensors.statusCode, body: resultSensors.body);
    }

    final sensorsMap = json.decode(resultSensors.body);

    List<SensorsEntity> listSensor = (sensorsMap as List)
        .map((dynamic json) => SensorsEntity.fromMap(json))
        .toList();

    final sensorsResultProcessed =
        SensorsCalculus.sensorsCalculus(listSensor: listSensor);

    final sensorsListMap =
        sensorsResultProcessed.map((sensor) => sensor.toMap()).toList();

    return Response(
      resultSensors.statusCode,
      body: JsonEncoder.withIndent(' ').convert(sensorsListMap),
    );
  }
}
