import '../models/forecast/weather_forecast_calculeted_model.dart';
import '../models/forecast/weather_forecast_data_model.dart';
import '../models/forecast/weather_forecast_week_calculated_model.dart';
import '../models/forecast/weather_forecast_model.dart';

abstract class ForecastCalculus {
  static WeatherForecastModel weatherHelper(
      {required WeatherForecastModel forecastModel}) {
    // Loop de todos os pontos de previsão
    final processedListPoint = forecastModel.forecastPoints.map(
      (forecastPoint) {
        WeatherForecastWeekCalculatedModel forecastWeek =
            WeatherForecastWeekCalculatedModel();

        // Loop de todos os dias da semana do respectivo ponto de previsão
        final pointCalculated = forecastPoint.data.map((forecastData) {
          WeatherForecastCalculatedModel forecastCalculated =
              WeatherForecastCalculatedModel();

          // Compara o valor do dia anterior com o dia atual, o maior fica.
          forecastWeek.greaterVolume = _calcMaxVol(
            forecastDataEntity: forecastData,
            maxVolume: forecastWeek.greaterVolume,
          );

          // Verifica se aquele dia haverá chuva e adiciona na semana.
          if (forecastData.pop >= 5) {
            forecastWeek.daysRain++;
          }

          // Calcula o total de expectativa de chuva na semana
          forecastWeek = _calcTotalExpectation(
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
          data: [
            pointCalculated[0],
          ],
        );
      },
    ).toList();
    final processed = forecastModel.copyWith(
      forecastPoints: processedListPoint,
    );
    return processed;
  }

  static int _calcMaxVol({
    required WeatherForecastDataModel forecastDataEntity,
    required int maxVolume,
  }) {
    int vol = forecastDataEntity.pcpTot + forecastDataEntity.pcpTotStd;
    if (maxVolume <= vol) {
      maxVolume = vol;
    }
    return maxVolume;
  }

  static WeatherForecastWeekCalculatedModel _calcTotalExpectation({
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
