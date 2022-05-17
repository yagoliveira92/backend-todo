import 'dart:convert';

import 'package:collection/collection.dart';

import 'soil_row_values_entity.dart';

class SoilRowEntity {


  String? depth;
  List<SoilRowValuesEntity> soilRowValues;
  SoilRowEntity({
    this.depth,
    required this.soilRowValues,
  });

  SoilRowEntity copyWith({
    String? depth,
    List<SoilRowValuesEntity>? soilRowValues,
  }) {
    return SoilRowEntity(
      depth: depth ?? this.depth,
      soilRowValues: soilRowValues ?? this.soilRowValues,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'depth': depth,
      'soilRowValues': soilRowValues.map((x) => x.toMap()).toList(),
    };
  }

  factory SoilRowEntity.fromMap(Map<String, dynamic> map) {
    return SoilRowEntity(
      depth: map['depth'] != null ? map['depth'] as String : null,
      soilRowValues: List<SoilRowValuesEntity>.from((map['soilRowValues'] as List<int>).map<SoilRowValuesEntity>((x) => SoilRowValuesEntity.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory SoilRowEntity.fromJson(String source) => SoilRowEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SoilRowEntity(depth: $depth, soilRowValues: $soilRowValues)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is SoilRowEntity &&
      other.depth == depth &&
      listEquals(other.soilRowValues, soilRowValues);
  }

  @override
  int get hashCode => depth.hashCode ^ soilRowValues.hashCode;
}
