import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:http/http.dart' as http;

import '../models/forecast/weather_forecast_model.dart';
import '../models/history_field_notebook/history_card_notebook.dart';
import '../models/sensors/sensors_entity.dart';
import '../utils/forecast_calculus.dart';
import '../utils/sensors_calculus.dart';

class HomeController {
  static homeHandler(Request request) async {
    final allParams = request.requestedUri.queryParameters;
    final getToken = request.headers['authorization'] ?? '';

    final urlHistoricals = Uri.https('staging.cultivointeligente.com.br',
        '/api/v4/equipments/historicals', allParams);
    final urlForecast = Uri.https(
        'staging.cultivointeligente.com.br',
        '/api/v4/forecasts/daily',
        {'organization_id': allParams['organization_id']});
    final urlSensors = Uri.https('staging.cultivointeligente.com.br',
        '/api/v4/widgets/equipment_measures', {
      'organization_id': allParams['organization_id'],
    });
    final urlFieldNotebook = Uri.https(
        'agrosmart-field-notebook.staging.cultivointeligente.com.br',
        '/field_notebook/archive_history', {
      'organization_id': allParams['organization_id'],
      'company_id': allParams['company_id'],
      'count': '3',
    });

    final resultHistoricals =
        await http.get(urlHistoricals, headers: {'authorization': getToken});
    if (resultHistoricals.statusCode > 300) {
      return Response(resultHistoricals.statusCode,
          body: resultHistoricals.body);
    }

    final resultForecast =
        await http.get(urlForecast, headers: {'authorization': getToken});
    if (resultForecast.statusCode > 300) {
      return Response(resultForecast.statusCode, body: resultForecast.body);
    }

    final resultSensors =
        await http.get(urlSensors, headers: {'authorization': getToken});
    if (resultSensors.statusCode > 300) {
      return Response(resultSensors.statusCode, body: resultSensors.body);
    }

    final resultHistoryFieldNotebook = await http
        .get(urlFieldNotebook, headers: {'authorization': getToken});
    if (resultHistoryFieldNotebook.statusCode > 300) {
      return Response(resultHistoryFieldNotebook.statusCode,
          body: resultHistoryFieldNotebook.body);
    }

    Map<String, dynamic> forecastMap = json.decode(resultForecast.body);
    WeatherForecastModel forecast = WeatherForecastModel.fromMap(forecastMap);

    forecast = forecast.copyWith(
      forecastPoints: [
        forecast.forecastPoints[0],
      ],
    );

    final forecastResultProcessed = ForecastCalculus.weatherHelper(
      forecastModel: forecast,
      isHome: true,
    );

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

    final historyMap = json.decode(resultHistoryFieldNotebook.body);

    List<HistoryHomeFieldNotebook> listHistory = (historyMap as List)
        .map((dynamic json) => HistoryHomeFieldNotebook.fromMap(json))
        .toList();

    final historyListMap = listHistory.map((sensor) => sensor.toMap()).toList();

    final fieldSetup = json.decode(resultHistoricals.body);

    final Map<String, dynamic> mapResult = {
      'forecast': forecastResultProcessed.toMap(),
      'sensors': sensorsListMap,
      'field_notebook': {
        'setup': fieldSetup['field_notebook_setup'],
        'historical': historyListMap,
      },
    };
    return Response(
      resultSensors.statusCode,
      body: JsonEncoder.withIndent(' ').convert(mapResult),
    );
  }
}
