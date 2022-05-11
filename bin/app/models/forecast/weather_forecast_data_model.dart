class WeatherForecastDataModel {
  WeatherForecastDataModel({
    required this.pop,
    required this.icon,
    required this.t2Max,
    required this.t2Min,
    required this.pcpTot,
    required this.rh2Max,
    required this.rh2Min,
    required this.wd10Avg,
    required this.ws10Avg,
    required this.ws10Max,
    required this.pcpTotStd,
    required this.forecastDate,
    String? cop,
  });

  final int pop;
  final String icon;
  final int t2Max;
  final int t2Min;
  final int pcpTot;
  final int rh2Max;
  final int rh2Min;
  final int wd10Avg;
  final int ws10Avg;
  final int ws10Max;
  final int pcpTotStd;
  final String forecastDate;
  String? cop;

  Map<String, dynamic> toMap() {
    return {
      'cop': cop,
      'pop': pop,
      'icon': icon,
      't2_max': t2Max,
      't2_min': t2Min,
      'pcp_tot': pcpTot,
      'rh2_max': rh2Max,
      'rh2_min': rh2Min,
      'wd10_avg': wd10Avg,
      'ws10_avg': ws10Avg,
      'ws10_max': ws10Max,
      'pcp_tot_std': pcpTotStd,
      'forecast_date': forecastDate,
    };
  }

  factory WeatherForecastDataModel.fromMap(Map<String, dynamic> map) {
    return WeatherForecastDataModel(
      cop: map['cop'],
      pop: map['pop'].toInt(),
      icon: map['icon'],
      t2Max: map['t2_max'].toInt(),
      t2Min: map['t2_min'].toInt(),
      pcpTot: map['pcp_tot'].toInt(),
      rh2Max: map['rh2_max'].toInt(),
      rh2Min: map['rh2_min'].toInt(),
      wd10Avg: map['wd10_avg'].toInt(),
      ws10Avg: map['ws10_avg'].toInt(),
      ws10Max: map['ws10_max'].toInt(),
      pcpTotStd: map['pcp_tot_std'].toInt(),
      forecastDate: map['forecast_date'],
    );
  }

  WeatherForecastDataModel copyWith({
    int? pop,
    String? icon,
    int? t2Max,
    int? t2Min,
    int? pcpTot,
    int? rh2Max,
    int? rh2Min,
    int? wd10Avg,
    int? ws10Avg,
    int? ws10Max,
    int? pcpTotStd,
    String? forecastDate,
  }) {
    return WeatherForecastDataModel(
      pop: pop ?? this.pop,
      icon: icon ?? this.icon,
      t2Max: t2Max ?? this.t2Max,
      t2Min: t2Min ?? this.t2Min,
      pcpTot: pcpTot ?? this.pcpTot,
      rh2Max: rh2Max ?? this.rh2Max,
      rh2Min: rh2Min ?? this.rh2Min,
      wd10Avg: wd10Avg ?? this.wd10Avg,
      ws10Avg: ws10Avg ?? this.ws10Avg,
      ws10Max: ws10Max ?? this.ws10Max,
      pcpTotStd: pcpTotStd ?? this.pcpTotStd,
      forecastDate: forecastDate ?? this.forecastDate,
    );
  }
}
