import 'dart:convert';

class TodoModel {
  String taskName;
  DateTime dateToEnd;
  String description;
  bool isDone;
  TodoModel({
    required this.taskName,
    required this.dateToEnd,
    required this.description,
    required this.isDone,
  });

  TodoModel copyWith({
    String? taskName,
    DateTime? dateToEnd,
    String? description,
    bool? isDone,
  }) {
    return TodoModel(
      taskName: taskName ?? this.taskName,
      dateToEnd: dateToEnd ?? this.dateToEnd,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'dateToEnd': dateToEnd.millisecondsSinceEpoch,
      'description': description,
      'isDone': isDone,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      taskName: map['task-name'],
      dateToEnd: DateTime.parse(map['date-end']),
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
        other.taskName == taskName &&
        other.dateToEnd == dateToEnd &&
        other.description == description &&
        other.isDone == isDone;
  }

  @override
  int get hashCode {
    return taskName.hashCode ^
        dateToEnd.hashCode ^
        description.hashCode ^
        isDone.hashCode;
  }
}
