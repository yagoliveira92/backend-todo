import 'dart:convert';

class WeatherForecastWeekCalculatedModel {
  WeatherForecastWeekCalculatedModel({
    this.daysRain = 0,
    this.maxWeekExpectationRain = 0,
    this.minWeekExpectationRain = 0,
    this.greaterVolume = 0,
  });

  int daysRain;
  int maxWeekExpectationRain;
  int minWeekExpectationRain;
  int greaterVolume;

  WeatherForecastWeekCalculatedModel copyWith({
    int? daysRain,
    int? maxWeekExpectationRain,
    int? minWeekExpectationRain,
    int? greaterVolume,
  }) {
    return WeatherForecastWeekCalculatedModel(
      daysRain: daysRain ?? this.daysRain,
      maxWeekExpectationRain:
          maxWeekExpectationRain ?? this.maxWeekExpectationRain,
      minWeekExpectationRain:
          minWeekExpectationRain ?? this.minWeekExpectationRain,
      greaterVolume: greaterVolume ?? this.greaterVolume,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'daysRain': daysRain,
      'maxWeekExpectationRain': maxWeekExpectationRain,
      'minWeekExpectationRain': minWeekExpectationRain,
      'greaterVolume': greaterVolume,
    };
  }

  factory WeatherForecastWeekCalculatedModel.fromMap(Map<String, dynamic> map) {
    return WeatherForecastWeekCalculatedModel(
      daysRain: map['daysRain'] as int,
      maxWeekExpectationRain: map['maxWeekExpectationRain'] as int,
      minWeekExpectationRain: map['minWeekExpectationRain'] as int,
      greaterVolume: map['greaterVolume'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherForecastWeekCalculatedModel.fromJson(String source) =>
      WeatherForecastWeekCalculatedModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherForecastWeekCalculatedModel(daysRain: $daysRain, maxWeekExpectationRain: $maxWeekExpectationRain, minWeekExpectationRain: $minWeekExpectationRain, greaterVolume: $greaterVolume)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherForecastWeekCalculatedModel &&
        other.daysRain == daysRain &&
        other.maxWeekExpectationRain == maxWeekExpectationRain &&
        other.minWeekExpectationRain == minWeekExpectationRain &&
        other.greaterVolume == greaterVolume;
  }

  @override
  int get hashCode {
    return daysRain.hashCode ^
        maxWeekExpectationRain.hashCode ^
        minWeekExpectationRain.hashCode ^
        greaterVolume.hashCode;
  }
}
