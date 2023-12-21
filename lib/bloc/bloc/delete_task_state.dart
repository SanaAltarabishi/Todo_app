part of 'delete_task_bloc.dart';

@immutable
sealed class DeleteTaskState {}

final class DeleteTaskInitial extends DeleteTaskState {}


class SuccessDelete extends DeleteTaskState {
}

class ErrorDelete extends DeleteTaskState{}

class LoadingDelete extends DeleteTaskState{}

class OfflineDelete extends DeleteTaskState{}
