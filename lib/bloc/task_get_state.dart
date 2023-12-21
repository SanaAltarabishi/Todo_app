part of 'task_get_bloc.dart';

@immutable
sealed class TaskGetState {}

final class TaskGetInitial extends TaskGetState {}

class Success extends TaskGetState {
  List<ShowTask> tasks;
  Success({
    required this.tasks,
  });
}

class Error extends TaskGetState {}

class Loading extends TaskGetState {}

class Offline extends TaskGetState {}
