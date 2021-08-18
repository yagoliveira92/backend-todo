import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

class TodoModel {
  ObjectId? id;
  String taskName;
  DateTime dateToEnd;
  String description;
  bool isDone;
  TodoModel({
    this.id,
    required this.taskName,
    required this.dateToEnd,
    required this.description,
    required this.isDone,
  });

  TodoModel copyWith({
    ObjectId? id,
    String? taskName,
    DateTime? dateToEnd,
    String? description,
    bool? isDone,
  }) {
    return TodoModel(
      id: id ?? this.id,
      taskName: taskName ?? this.taskName,
      dateToEnd: dateToEnd ?? this.dateToEnd,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> modelMap = {
      'task-name': taskName,
      'date-to-end': dateToEnd.toString(),
      'description': description,
      'is-done': isDone,
    };
    if (id != null) {
      modelMap.addAll({
        'id': id!.$oid,
      });
    }
    return modelMap;
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['_id'],
      taskName: map['task-name'],
      dateToEnd: map['date-to-end'] is String
          ? DateTime.parse(map['date-to-end'])
          : map['date-to-end'],
      description: map['description'],
      isDone: map['is-done'] == 'true',
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TodoModel(taskName: $taskName, dateToEnd: $dateToEnd, description: $description, isDone: $isDone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoModel &&
        other.id == id &&
        other.taskName == taskName &&
        other.dateToEnd == dateToEnd &&
        other.description == description &&
        other.isDone == isDone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        taskName.hashCode ^
        dateToEnd.hashCode ^
        description.hashCode ^
        isDone.hashCode;
  }
}
