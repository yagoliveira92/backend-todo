import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:http/http.dart' as http;

import '../models/forecast/weather_forecast_model.dart';
import '../utils/forecast_calculus.dart';

class ForecastController {
  static forecastHandler(Request request) async {
    final allParams = request.requestedUri.queryParameters;
    final getToken = request.headers['authorization'] ?? '';

    final urlForecast = Uri.https(
      'staging.cultivointeligente.com.br',
      '/api/v4/forecasts/daily',
      {'organization_id': allParams['organization_id']},
    );

    final resultForecast =
        await http.get(urlForecast, headers: {'authorization': getToken});
    if (resultForecast.statusCode > 300) {
      return Response(resultForecast.statusCode, body: resultForecast.body);
    }
    Map<String, dynamic> forecastMap = json.decode(resultForecast.body);
    WeatherForecastModel forecast = WeatherForecastModel.fromMap(forecastMap);

    final forecastResultProcessed =
        ForecastCalculus.weatherHelper(forecastModel: forecast);

    return Response(
      resultForecast.statusCode,
      body: JsonEncoder.withIndent(' ').convert(
        forecastResultProcessed.toMap(),
      ),
    );
  }
}
