import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/model/add_task_model.dart';
import 'package:todo/todo_service.dart';


part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  AddTaskBloc() : super(AddTaskInitial()) {
    on<PostTask>((event, emit) async {
      try {
        emit(Loading());
        bool temp = await TaskServiceImp().addNewTask(event.task);
        if (temp) {
          emit(Success());
          print(temp);
        } else {
          emit(Error());
        }
      } catch (e) {
        emit(Offline());
      }
    });
  }
}
