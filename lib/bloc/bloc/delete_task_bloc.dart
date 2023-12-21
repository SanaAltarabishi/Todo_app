import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/todo_service.dart';

part 'delete_task_event.dart';
part 'delete_task_state.dart';

class DeleteTaskBloc extends Bloc<DeleteTaskEvent, DeleteTaskState> {
  DeleteTaskBloc() : super(DeleteTaskInitial()) {
    on<DeleteTask>((event, emit) async{
    
  //  try {
        emit(LoadingDelete());
      dynamic temp = await TaskServiceImp().deleteTask(event.id);
        if (temp) {
          emit(SuccessDelete());
          print(temp);
        } else {
          emit(ErrorDelete());
        }
      // } catch (e) {
      //   emit(OfflineDelete());
      // }

    });
  }
}
