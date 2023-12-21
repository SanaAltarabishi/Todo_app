import 'package:dio/dio.dart';
import 'package:todo/model/add_task_model.dart';

abstract class TaskService {
  Dio dio = Dio();
  final String baseUrl = 'https://657217b9d61ba6fcc0145f9e.mockapi.io/todos';
  addNewTask(AddTask task);
}

class TaskServiceImp extends TaskService {
  @override
  addNewTask(AddTask task) async {
    print(task.toJson());
    Response response = await dio.post(baseUrl,
        data: task.toJson(),
        options: Options(headers: {"Content-Type": 'application/json'}));

    if (response.statusCode == 201) {
      print(response.data);
      return true;
    } else {
      print('error');
      return false;
    }
  }

  getTask() async {
    try {
      Response response = await dio.get(baseUrl);
      print(response.data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'false';
      }
    } catch (e) {
      throw e;
    }
  }

  deleteTask(String id) async {
    //try{

    Response responseDelete = await dio.delete(baseUrl + '/${id}');

    print('Response status: ${responseDelete.statusCode}');
    print('Response data: ${responseDelete.data}');
    if (responseDelete.statusCode == 200) {
      return true;
    } else {
      return false;
    }
    //   }on DioException catch(e){
    //     if (e.response?.statusCode==400){
    //       print('bad request:${e.response?.data}');
    //     }else{
    //       print('Request failed:${e.response?.statusCode}');
    //     }
    //   }
    //   catch(e){
    //      print('Error in delete');
    //   }
  }

  updateTask(String id, bool check) async {
    // try {
    Response response=  await dio.put(
        baseUrl +'/${id}',
        data: {"check": check},
      );
      if (response.statusCode == 200) {
    // Update was successful
    print('Boolean value updated successfully');
  } else {
    // Handle error
    print('Failed to update boolean value. Status code: ${response.statusCode}');
  }
    // } catch (e) {
    //   print('error in update');
    // }
  }
}
