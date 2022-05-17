import 'dart:convert';

class SoilRowValuesEntity {
  String? typeSoil;
  String? value;
  SoilRowValuesEntity({
    this.typeSoil,
    this.value,
  });

  SoilRowValuesEntity copyWith({
    String? typeSoil,
    String? value,
  }) {
    return SoilRowValuesEntity(
      typeSoil: typeSoil ?? this.typeSoil,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'typeSoil': typeSoil,
      'value': value,
    };
  }

  factory SoilRowValuesEntity.fromMap(Map<String, dynamic> map) {
    return SoilRowValuesEntity(
      typeSoil: map['typeSoil'] != null ? map['typeSoil'] as String : null,
      value: map['value'] != null ? map['value'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SoilRowValuesEntity.fromJson(String source) =>
      SoilRowValuesEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SoilRowValuesEntity(typeSoil: $typeSoil, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SoilRowValuesEntity &&
        other.typeSoil == typeSoil &&
        other.value == value;
  }

  @override
  int get hashCode => typeSoil.hashCode ^ value.hashCode;
}
