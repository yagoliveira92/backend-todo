import 'dart:convert';

import 'package:collection/collection.dart';

import 'descriptions_entity.dart';
import 'equipment_status_entity.dart';
import 'soil_table/soil_table_entity.dart';

class SensorsEntity {
  String? measuredAt;
  List<DescriptionSensorsEntity> descriptions;
  EquipmentStatusSensorsEntity? equipmentStatus;
  String? name;
  int? equipmentId;
  SoilTableEntity? soilTable;
  String? battery;
  SensorsEntity({
    this.measuredAt,
    required this.descriptions,
    this.equipmentStatus,
    this.name,
    this.equipmentId,
    this.soilTable,
    this.battery,
  });

  SensorsEntity copyWith({
    String? measuredAt,
    List<DescriptionSensorsEntity>? descriptions,
    EquipmentStatusSensorsEntity? equipmentStatus,
    String? name,
    int? equipmentId,
    SoilTableEntity? soilTable,
    String? battery,
  }) {
    return SensorsEntity(
      measuredAt: measuredAt ?? this.measuredAt,
      descriptions: descriptions ?? this.descriptions,
      equipmentStatus: equipmentStatus ?? this.equipmentStatus,
      name: name ?? this.name,
      equipmentId: equipmentId ?? this.equipmentId,
      soilTable: soilTable ?? this.soilTable,
      battery: battery ?? this.battery,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'measuredAt': measuredAt,
      'descriptions': descriptions.map((x) => x.toMap()).toList(),
      'equipmentStatus': equipmentStatus?.toMap(),
      'name': name,
      'equipmentId': equipmentId,
      'soilTable': soilTable?.toMap(),
      'battery': battery,
    };
  }

  factory SensorsEntity.fromMap(Map<String, dynamic> map) {
    return SensorsEntity(
      measuredAt:
          map['measuredAt'] != null ? map['measuredAt'] as String : null,
      descriptions: List<DescriptionSensorsEntity>.from(
        map['descriptions'].map<DescriptionSensorsEntity>(
          (x) => DescriptionSensorsEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      equipmentStatus: map['equipmentStatus'] != null
          ? EquipmentStatusSensorsEntity.fromMap(
              map['equipmentStatus'] as Map<String, dynamic>)
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      equipmentId:
          map['equipmentId'] != null ? map['equipmentId'] as int : null,
      soilTable: map['soilTable'] != null
          ? SoilTableEntity.fromMap(map['soilTable'] as Map<String, dynamic>)
          : null,
      battery: map['battery'] != null ? map['battery'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SensorsEntity.fromJson(String source) =>
      SensorsEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SensorsEntity(measuredAt: $measuredAt, descriptions: $descriptions, equipmentStatus: $equipmentStatus, name: $name, equipmentId: $equipmentId, soilTable: $soilTable, battery: $battery)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is SensorsEntity &&
        other.measuredAt == measuredAt &&
        listEquals(other.descriptions, descriptions) &&
        other.equipmentStatus == equipmentStatus &&
        other.name == name &&
        other.equipmentId == equipmentId &&
        other.soilTable == soilTable &&
        other.battery == battery;
  }

  @override
  int get hashCode {
    return measuredAt.hashCode ^
        descriptions.hashCode ^
        equipmentStatus.hashCode ^
        name.hashCode ^
        equipmentId.hashCode ^
        soilTable.hashCode ^
        battery.hashCode;
  }
}
