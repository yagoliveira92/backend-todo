import 'dart:convert';

class DescriptionSensorsEntity {
  String? name;
  String description;
  String shortDescription;
  String? unit;
  String? depth;
  int? index;
  String? value;
  String? itemSensor;
  DescriptionSensorsEntity({
    this.name,
    required this.description,
    required this.shortDescription,
    this.unit,
    this.depth,
    this.index,
    this.value,
    this.itemSensor,
  });

  DescriptionSensorsEntity copyWith({
    String? name,
    String? description,
    String? shortDescription,
    String? unit,
    String? depth,
    int? index,
    String? value,
    String? itemSensor,
  }) {
    return DescriptionSensorsEntity(
      name: name ?? this.name,
      description: description ?? this.description,
      shortDescription: shortDescription ?? this.shortDescription,
      unit: unit ?? this.unit,
      depth: depth ?? this.depth,
      index: index ?? this.index,
      value: value ?? this.value,
      itemSensor: itemSensor ?? this.itemSensor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'shortDescription': shortDescription,
      'unit': unit,
      'depth': depth,
      'index': index,
      'value': value,
      'itemSensor': itemSensor,
    };
  }

  factory DescriptionSensorsEntity.fromMap(Map<String, dynamic> map) {
    return DescriptionSensorsEntity(
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] as String,
      shortDescription: map['short_description'] as String,
      unit: map['unit'] != null ? map['unit'] as String : null,
      depth: map['depth'] != null ? map['depth'] as String : null,
      index: map['index'] != null ? map['index'] as int : null,
      value: map['value'] != null ? map['value'] as String : null,
      itemSensor:
          map['item_sensor'] != null ? map['item_sensor'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DescriptionSensorsEntity.fromJson(String source) =>
      DescriptionSensorsEntity.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DescriptionSensorsEntity(name: $name, description: $description, shortDescription: $shortDescription, unit: $unit, depth: $depth, index: $index, value: $value, itemSensor: $itemSensor)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DescriptionSensorsEntity &&
        other.name == name &&
        other.description == description &&
        other.shortDescription == shortDescription &&
        other.unit == unit &&
        other.depth == depth &&
        other.index == index &&
        other.value == value &&
        other.itemSensor == itemSensor;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        shortDescription.hashCode ^
        unit.hashCode ^
        depth.hashCode ^
        index.hashCode ^
        value.hashCode ^
        itemSensor.hashCode;
  }
}
