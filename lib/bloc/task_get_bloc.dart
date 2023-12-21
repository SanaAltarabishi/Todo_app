import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/model/show_task_model.dart';
import 'package:todo/todo_service.dart';


part 'task_get_event.dart';
part 'task_get_state.dart';

class TaskGetBloc extends Bloc<TaskGetEvent, TaskGetState> {
  TaskGetBloc() : super(TaskGetInitial()) {
    on<GetTask>((event, emit) async {
      // try {
        emit(Loading());
        final dynamic temp = await TaskServiceImp().getTask();
        print('bla bla ');
        if (temp is String) {
          emit(Error());
        } else {
          List<ShowTask> tasks = List.generate(
              temp.length, (index) => ShowTask.fromMap(temp[index]));
          emit(Success(tasks: tasks));
        }
      // } catch (e) {
      //   emit(Offline());
      // }
    });
  }
}
