part of 'delete_task_bloc.dart';

@immutable
sealed class DeleteTaskEvent {}

class DeleteTask extends DeleteTaskEvent {
  String id;
  DeleteTask({
    required this.id,
  });
}
