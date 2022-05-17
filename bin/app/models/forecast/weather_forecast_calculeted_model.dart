// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherForecastCalculatedModel {
  int maxDayExpectationRain;
  int minDayExpectationRain;

  WeatherForecastCalculatedModel({
    this.maxDayExpectationRain = 0,
    this.minDayExpectationRain = 0,
  });

  WeatherForecastCalculatedModel copyWith({
    int? maxDayExpectationRain,
    int? minDayExpectationRain,
  }) {
    return WeatherForecastCalculatedModel(
      maxDayExpectationRain:
          maxDayExpectationRain ?? this.maxDayExpectationRain,
      minDayExpectationRain:
          minDayExpectationRain ?? this.minDayExpectationRain,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'maxDayExpectationRain': maxDayExpectationRain,
      'minDayExpectationRain': minDayExpectationRain,
    };
  }

  factory WeatherForecastCalculatedModel.fromMap(Map<String, dynamic> map) {
    return WeatherForecastCalculatedModel(
      maxDayExpectationRain: map['maxDayExpectationRain'] as int,
      minDayExpectationRain: map['minDayExpectationRain'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherForecastCalculatedModel.fromJson(String source) =>
      WeatherForecastCalculatedModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'WeatherForecastCalculatedModel(maxDayExpectationRain: $maxDayExpectationRain, minDayExpectationRain: $minDayExpectationRain)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherForecastCalculatedModel &&
        other.maxDayExpectationRain == maxDayExpectationRain &&
        other.minDayExpectationRain == minDayExpectationRain;
  }

  @override
  int get hashCode =>
      maxDayExpectationRain.hashCode ^ minDayExpectationRain.hashCode;
}
