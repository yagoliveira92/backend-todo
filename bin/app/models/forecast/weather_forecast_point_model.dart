import 'weather_forecast_data_model.dart';
import 'weather_forecast_week_calculated_model.dart';

class WeatherForecastPointModel {
  WeatherForecastPointModel({
    required this.id,
    required this.name,
    required this.lon,
    required this.lat,
    required this.setUp,
    required this.data,
    this.weatherForecastWeekCalculated,
  });

  final int id;
  final String name;
  final String lon;
  final String lat;
  final bool setUp;
  final List<WeatherForecastDataModel> data;
  WeatherForecastWeekCalculatedModel? weatherForecastWeekCalculated;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lon': lon,
      'lat': lat,
      'set_up': setUp,
      'week_calculated': weatherForecastWeekCalculated?.toMap(),
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

  WeatherForecastPointModel copyWith(
      {int? id,
      String? name,
      String? lon,
      String? lat,
      bool? setUp,
      List<WeatherForecastDataModel>? data,
      WeatherForecastWeekCalculatedModel? weatherForecastWeekCalculated}) {
    return WeatherForecastPointModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lon: lon ?? this.lon,
      lat: lat ?? this.lat,
      setUp: setUp ?? this.setUp,
      data: data ?? this.data,
      weatherForecastWeekCalculated:
          weatherForecastWeekCalculated ?? this.weatherForecastWeekCalculated,
    );
  }
}
