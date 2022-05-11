import 'weather_forecast_point_model.dart';

class WeatherForecastModel {
  WeatherForecastModel({
    required this.forecastPoints,
  });

  final List<WeatherForecastPointModel> forecastPoints;

  Map<String, dynamic> toMap() {
    return {
      'forecast_points': forecastPoints.map(
        (forecastPoint) {
          return forecastPoint.toMap();
        },
      ).toList(),
    };
  }

  factory WeatherForecastModel.fromMap(Map<String, dynamic> map) {
    return WeatherForecastModel(
      forecastPoints: List<WeatherForecastPointModel>.from(
        map['forecast_points'].map(
          (map) => WeatherForecastPointModel.fromMap(map),
        ),
      ),
    );
  }
}
