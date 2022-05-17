import 'dart:convert';

class EquipmentStatusSensorsEntity {
  bool? online;
  bool? installed;
  EquipmentStatusSensorsEntity({
    this.online,
    this.installed,
  });

  EquipmentStatusSensorsEntity copyWith({
    bool? online,
    bool? installed,
  }) {
    return EquipmentStatusSensorsEntity(
      online: online ?? this.online,
      installed: installed ?? this.installed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'online': online,
      'installed': installed,
    };
  }

  factory EquipmentStatusSensorsEntity.fromMap(Map<String, dynamic> map) {
    return EquipmentStatusSensorsEntity(
      online: map['online'] != null ? map['online'] as bool : null,
      installed: map['installed'] != null ? map['installed'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EquipmentStatusSensorsEntity.fromJson(String source) =>
      EquipmentStatusSensorsEntity.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'EquipmentStatusSensorsEntity(online: $online, installed: $installed)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EquipmentStatusSensorsEntity &&
        other.online == online &&
        other.installed == installed;
  }

  @override
  int get hashCode => online.hashCode ^ installed.hashCode;
}
