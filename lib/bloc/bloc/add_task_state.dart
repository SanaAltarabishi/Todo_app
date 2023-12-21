part of 'add_task_bloc.dart';

@immutable
sealed class AddTaskState {}

final class AddTaskInitial extends AddTaskState {}

class Success extends AddTaskState {
}

class Error extends AddTaskState{}

class Loading extends AddTaskState{}

class Offline extends AddTaskState{}
