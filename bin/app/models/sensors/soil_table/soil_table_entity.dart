import 'dart:convert';

import 'package:collection/collection.dart';

import 'soil_row_entity.dart';

class SoilTableEntity {
  List<String>? headerTable;
  List<SoilRowEntity>? soilVariables;
  SoilTableEntity({
    this.headerTable,
    this.soilVariables,
  });

  SoilTableEntity copyWith({
    List<String>? headerTable,
    List<SoilRowEntity>? soilVariables,
  }) {
    return SoilTableEntity(
      headerTable: headerTable ?? this.headerTable,
      soilVariables: soilVariables ?? this.soilVariables,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'headerTable': headerTable,
      'soilVariables': soilVariables?.map((x) => x.toMap()).toList(),
    };
  }

  factory SoilTableEntity.fromMap(Map<String, dynamic> map) {
    return SoilTableEntity(
      headerTable: List<String>.from((map['headerTable'] as List<String>)),
      soilVariables: List<SoilRowEntity>.from(
        (map['soilVariables'] as List<int>).map<SoilRowEntity>(
          (x) => SoilRowEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SoilTableEntity.fromJson(String source) =>
      SoilTableEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SoilTableEntity(headerTable: $headerTable, soilVariables: $soilVariables)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is SoilTableEntity &&
        listEquals(other.headerTable, headerTable) &&
        listEquals(other.soilVariables, soilVariables);
  }

  @override
  int get hashCode => headerTable.hashCode ^ soilVariables.hashCode;
}
