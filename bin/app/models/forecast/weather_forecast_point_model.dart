import 'weather_forecast_data_model.dart';

class WeatherForecastPointModel {
  WeatherForecastPointModel({
    required this.id,
    required this.name,
    required this.lon,
    required this.lat,
    required this.setUp,
    required this.data,
  });

  final int id;
  final String name;
  final String lon;
  final String lat;
  final bool setUp;
  final List<WeatherForecastDataModel> data;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lon': lon,
      'lat': lat,
      'set_up': setUp,
      'data': data.map(
        (forecast) {
          return forecast.toMap();
        },
      ).toList(),
    };
  }

  factory WeatherForecastPointModel.fromMap(Map<String, dynamic> map) {
    return WeatherForecastPointModel(
      id: map['id'],
      name: map['name'],
      lon: map['lon'],
      lat: map['lat'],
      setUp: map['set_up'],
      data: List<WeatherForecastDataModel>.from(
        map['data']?.map(
          (map) => WeatherForecastDataModel.fromMap(map),
        ),
      ),
    );
  }
}
