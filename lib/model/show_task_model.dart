// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ShowTask {
  final num taskNumber;
  final String taskName;
  final String explain;
 bool check; 
  final String id;
  ShowTask({
    required this.taskNumber,
    required this.taskName,
    required this.explain,
    required this.check,
    required this.id,
  });

  ShowTask copyWith({
    num? taskNumber,
    String? taskName,
    String? explain,
    bool? check,
    String? id,
  }) {
    return ShowTask(
      taskNumber: taskNumber ?? this.taskNumber,
      taskName: taskName ?? this.taskName,
      explain: explain ?? this.explain,
      check: check ?? this.check,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskNumber': taskNumber,
      'taskName': taskName,
      'explain': explain,
      'check': check,
      'id': id,
    };
  }

  factory ShowTask.fromMap(Map<String, dynamic> map) {
    return ShowTask(
      taskNumber: map['taskNumber'] as num,
      taskName: map['taskName'] as String,
      explain: map['explain'] as String,
      check: map['check'] as bool,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShowTask.fromJson(String source) => ShowTask.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShowTask(taskNumber: $taskNumber, taskName: $taskName, explain: $explain, check: $check, id: $id)';
  }

  @override
  bool operator ==(covariant ShowTask other) {
    if (identical(this, other)) return true;
  
    return 
      other.taskNumber == taskNumber &&
      other.taskName == taskName &&
      other.explain == explain &&
      other.check == check &&
      other.id == id;
  }

  @override
  int get hashCode {
    return taskNumber.hashCode ^
      taskName.hashCode ^
      explain.hashCode ^
      check.hashCode ^
      id.hashCode;
  }
}
