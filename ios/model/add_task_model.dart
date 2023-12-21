// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddTask {
  final num taskNumber;
  final String taskName;
  final bool check;
  AddTask({
    required this.taskNumber,
    required this.taskName,
    required this.check,
  });

  AddTask copyWith({
    num? taskNumber,
    String? taskName,
    bool? check,
  }) {
    return AddTask(
      taskNumber: taskNumber ?? this.taskNumber,
      taskName: taskName ?? this.taskName,
      check: check ?? this.check,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskNumber': taskNumber,
      'taskName': taskName,
      'check': check,
    };
  }

  factory AddTask.fromMap(Map<String, dynamic> map) {
    return AddTask(
      taskNumber: map['taskNumber'] as num,
      taskName: map['taskName'] as String,
      check: map['check'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddTask.fromJson(String source) => AddTask.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AddTask(taskNumber: $taskNumber, taskName: $taskName, check: $check)';

  @override
  bool operator ==(covariant AddTask other) {
    if (identical(this, other)) return true;
  
    return 
      other.taskNumber == taskNumber &&
      other.taskName == taskName &&
      other.check == check;
  }

  @override
  int get hashCode => taskNumber.hashCode ^ taskName.hashCode ^ check.hashCode;
} 
