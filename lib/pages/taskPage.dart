import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/bloc/add_task_bloc.dart';
import 'package:todo/bloc/bloc/delete_task_bloc.dart';
import 'package:todo/model/add_task_model.dart';
import 'package:todo/pages/show_add_task.dart';
import 'package:todo/todo_service.dart';


final _formKey = GlobalKey<FormState>();

class TaskPage extends StatelessWidget {
  TaskPage({super.key});

  TextEditingController _taskNumber = TextEditingController();
  TextEditingController _taskName = TextEditingController();

  TaskServiceImp taskayh = TaskServiceImp();

  @override
  Widget build(BuildContext context) {
    return
        //i add it in the myapp
        BlocProvider(
      create: (context) => AddTaskBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: BlocListener<AddTaskBloc, AddTaskState>(
            listener: (context, state) {
              if (state is Success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor:Color.fromARGB(255, 111, 134, 198),
                    action: SnackBarAction(label: "", onPressed: () {}),
                    content: const Text("Thank you for adding new task"),
                    duration: Duration(seconds: 1),
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  ShowAddTaskPage()),
                );
              } else if (State is Error) {
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  action: SnackBarAction(label: "", onPressed: () {}),
                  content: const Text("Sorry you can`t add"),
                  duration: Duration(seconds: 1),
                ));
              } else if (State is Offline) {
                 ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.grey,
                  action: SnackBarAction(label: "", onPressed: () {}),
                  content: const Text("You are offline"),
                  duration: Duration(seconds: 1),
                ));
              }
            },
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      "Add Task",
                      style: TextStyle(
                          fontSize: 36,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _taskNumber,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            'taskNumber',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter the task number';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _taskName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            'Task name ',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter the task name';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AddTaskBloc>().add(
                                  PostTask(
                                    task: AddTask(
                                      taskNumber:
                                          num.tryParse(_taskNumber.text) ?? 0.0,
                                      taskName: _taskName.text,
                                      check: false,
                                    ),
                                  ),
                                );
                          }
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const ShowAddTaskPage()),
                          // );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:  Color.fromARGB(255, 111, 134, 198),
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 350,
                          height: 50,
                          child: Center(
                            child: Text('ADD',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
