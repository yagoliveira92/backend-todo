// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HistoryHomeFieldNotebook {
  int? formDate;
  String? formName;
  HistoryHomeFieldNotebook({
    this.formDate,
    this.formName,
  });

  HistoryHomeFieldNotebook copyWith({
    int? formDate,
    String? formName,
  }) {
    return HistoryHomeFieldNotebook(
      formDate: formDate ?? this.formDate,
      formName: formName ?? this.formName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'form_date': formDate,
      'form_name': formName,
    };
  }

  factory HistoryHomeFieldNotebook.fromMap(Map<String, dynamic> map) {
    return HistoryHomeFieldNotebook(
      formDate: map['form_date'] != null ? map['form_date'] as int : null,
      formName: map['form_name'] != null ? map['form_name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryHomeFieldNotebook.fromJson(String source) =>
      HistoryHomeFieldNotebook.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'HistoryHomeFieldNotebook(formDate: $formDate, formName: $formName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoryHomeFieldNotebook &&
        other.formDate == formDate &&
        other.formName == formName;
  }

  @override
  int get hashCode => formDate.hashCode ^ formName.hashCode;
}
