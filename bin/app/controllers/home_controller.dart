import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:http/http.dart' as http;

import '../models/forecast/weather_forecast_model.dart';
import '../models/sensors/sensors_entity.dart';
import '../utils/forecast_calculus.dart';
import '../utils/sensors_calculus.dart';

class HomeController {
  static homeHandler(Request request) async {
    final _allParams = request.requestedUri.queryParameters;
    final _getToken = request.headers['authorization'] ?? '';

    final _urlHistoricals = Uri.https('staging.cultivointeligente.com.br',
        '/api/v4/equipments/historicals', _allParams);
    final _urlForecast = Uri.https(
        'staging.cultivointeligente.com.br',
        '/api/v4/forecasts/daily',
        {'organization_id': _allParams['organization_id']});
    final _urlSensors = Uri.https('staging.cultivointeligente.com.br',
        '/api/v4/widgets/equipment_measures', {
      'organization_id': _allParams['organization_id'],
      'lenght': _allParams['lenght']
    });

    final resultHistoricals =
        await http.get(_urlHistoricals, headers: {'authorization': _getToken});
    final resultForecast =
        await http.get(_urlForecast, headers: {'authorization': _getToken});
    final resultSensors =
        await http.get(_urlSensors, headers: {'authorization': _getToken});

    Map<String, dynamic> forecastMap = json.decode(resultForecast.body);
    WeatherForecastModel forecast = WeatherForecastModel.fromMap(forecastMap);

    forecast = forecast.copyWith(
      forecastPoints: [
        forecast.forecastPoints[0],
      ],
    );

    final forecastResultProcessed =
        ForecastCalculus.weatherHelper(forecastModel: forecast);

    final sensorsMap = json.decode(resultSensors.body);

    List<SensorsEntity> listSensor = (sensorsMap as List)
        .map((dynamic json) => SensorsEntity.fromMap(json))
        .toList();

    final sensorsResultProcessed =
        SensorsCalculus.sensorsCalculus(listSensor: listSensor);

    final sensorsListMap = sensorsResultProcessed
        .map((sensor) => sensor.toMap())
        .toList()
        .getRange(0, 3)
        .toList();

    final fieldSetup = json.decode(resultHistoricals.body);

    final Map<String, dynamic> mapResult = {
      'forecast': forecastResultProcessed.toMap(),
      'sensors': sensorsListMap,
      'field_notebook_setup': fieldSetup['field_notebook_setup'],
    };
    return Response(
      resultSensors.statusCode,
      body: JsonEncoder.withIndent(' ').convert(mapResult),
    );
  }
}
