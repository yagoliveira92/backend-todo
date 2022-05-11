import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:http/http.dart' as http;

import '../models/forecast/weather_forecast_calculeted_model.dart';
import '../models/forecast/weather_forecast_data_model.dart';
import '../models/forecast/weather_forecast_model.dart';
import '../models/forecast/weather_forecast_week_calculated_model.dart';

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

    try {
      final resultHistoricals = await http
          .get(_urlHistoricals, headers: {'authorization': _getToken});
      final resultForecast =
          await http.get(_urlForecast, headers: {'authorization': _getToken});
      final resultSensors =
          await http.get(_urlSensors, headers: {'authorization': _getToken});

      Map<String, dynamic> forecastMap = json.decode(resultForecast.body);
      WeatherForecastModel forecast = WeatherForecastModel.fromMap(forecastMap);

      final Map<String, dynamic> mapResult = {
        'forecast': forecast.forecastPoints[0].toMap(),
        'historicals': json.decode(resultHistoricals.body),
        // 'sensors': allSensors.getRange(0, 2),
      };
      print(mapResult);
      return Response(
        resultSensors.statusCode,
        body: JsonEncoder.withIndent(' ').convert(mapResult),
      );
    } catch (e) {
      return Response.badRequest(body: e);
    }
  }

  void _weatherHelper({required WeatherForecastModel forecastModel}) {
    // Loop de todos os pontos de previsão
    forecastModel.forecastPoints.map(
      (forecastPoint) {
        WeatherForecastWeekCalculatedModel forecastWeek =
            WeatherForecastWeekCalculatedModel();

        // Loop de todos os dias da semana do respectivo ponto de previsão
        forecastPoint.data.map((forecastData) {
          WeatherForecastCalculatedModel forecastCalculated =
              WeatherForecastCalculatedModel();

          // Compara o valor do dia anterior com o dia atual, o maior fica.
          forecastWeek.greaterVolume = calcMaxVol(
            forecastDataEntity: forecastData,
            maxVolume: forecastWeek.greaterVolume,
          );

          // Verifica se aquele dia haverá chuva e adiciona na semana.
          if (forecastData.pop >= 5) {
            forecastWeek.daysRain++;
          }

          // Calcula o total de expectativa de chuva na semana
          forecastWeek = calcTotalExpectation(
            forecastDataEntity: forecastData,
            forecastWeekCalculated: forecastWeek,
          );

          // Calcula o máximo e o mínimo do dia
          forecastCalculated.maxDayExpectationRain =
              forecastData.pcpTot + forecastData.pcpTotStd;
          if ((forecastData.pcpTot - forecastData.pcpTotStd) > 0) {
            forecastCalculated.minDayExpectationRain =
                forecastData.pcpTot - forecastData.pcpTotStd;
          } else {
            forecastCalculated.minDayExpectationRain = 0;
          }

          // Copia os valores do dia com os cálculados
          return forecastData.copyWith(
            weatherForecastCalculated: forecastCalculated,
          );
        }).toList();
        return forecastPoint.copyWith(
          weatherForecastWeekCalculated: forecastWeek,
        );
      },
    ).toList();
  }

  int calcMaxVol({
    required WeatherForecastDataModel forecastDataEntity,
    required int maxVolume,
  }) {
    int vol = forecastDataEntity.pcpTot + forecastDataEntity.pcpTotStd;
    if (maxVolume <= vol) {
      maxVolume = vol;
    }
    return maxVolume;
  }

  WeatherForecastWeekCalculatedEntity calcTotalExpectation({
    required WeatherForecastDataModel forecastDataEntity,
    required WeatherForecastWeekCalculatedModel forecastWeekCalculated,
  }) {
    final max = forecastDataEntity.pcpTot + forecastDataEntity.pcpTotStd;
    final min = forecastDataEntity.pcpTot - forecastDataEntity.pcpTotStd;

    forecastWeekCalculated.maxWeekExpectationRain =
        forecastWeekCalculated.maxWeekExpectationRain + max;

    forecastWeekCalculated.minWeekExpectationRain =
        forecastWeekCalculated.minWeekExpectationRain + min;
    if (forecastWeekCalculated.minWeekExpectationRain < 0) {
      forecastWeekCalculated.minWeekExpectationRain = 0;
    }

    return forecastWeekCalculated;
  }
}
