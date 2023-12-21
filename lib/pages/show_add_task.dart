import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/bloc/delete_task_bloc.dart';
import 'package:todo/bloc/task_get_bloc.dart';
import 'package:todo/pages/taskPage.dart';
import 'package:todo/todo_service.dart';

TaskServiceImp apiDelet = TaskServiceImp();

class ShowAddTaskPage extends StatefulWidget {
  @override
  State<ShowAddTaskPage> createState() => _ShowAddTaskPageState();
}

class _ShowAddTaskPageState extends State<ShowAddTaskPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskGetBloc()..add(GetTask()),
        ),
        BlocProvider(
          create: (context) => DeleteTaskBloc(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            tooltip: 'Add',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => TaskPage(),
              );
            },
            backgroundColor: Color.fromARGB(255, 111, 134, 198),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          //  backgroundColor: Color.fromARGB(255, 57, 54, 108),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/stars.jpg'), fit: BoxFit.fill),
            ),
            child: BlocConsumer<DeleteTaskBloc, DeleteTaskState>(
              listener: (context, state) {
               if (state is SuccessDelete){ Navigator.push(context,MaterialPageRoute(builder:(context) => ShowAddTaskPage(),));}
                ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                  backgroundColor: Colors.black,
                  action: SnackBarAction(label: "", onPressed: () {}),
                  content: const Text("Delete"),
                  duration: Duration(seconds: 1),
                ));
              },
              builder: (context, state) {
                return BlocBuilder<TaskGetBloc, TaskGetState>(
                  builder: (context, state) {
                    if (state is Error) {
                      return Center(
                        child: Text('Error'),
                      );
                    } else if (state is Success) {
                      return Container(
                        padding: EdgeInsets.only(
                            top: 25, left: 35, right: 35, bottom: 40),
                        child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'To DO',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 28,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${state.tasks.length} Tasks',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 500,
                                    child: ListView.builder(
                                        itemCount: state.tasks.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final item = state.tasks[index];
                                          return StatefulBuilder(
                                              builder: (context, setstate) {
                                            return ListTile(
                                              onLongPress: () async {
                                                final myDeletBloc = context
                                                    .read<DeleteTaskBloc>()
                                                    .add(DeleteTask(
                                                        id: state
                                                            .tasks[index].id));
                                                // TaskServiceImp apiDelet =
                                                //     TaskServiceImp();

                                                // await apiDelet.deleteTask(
                                                //     state.tasks[index].id);

                                                //  deleteItem(state.tasks[index].id);
                                              },
                                              title: Text(
                                                state.tasks[index].taskName,
                                                style: TextStyle(
                                                    decoration:
                                                        state.tasks[index].check
                                                            ? TextDecoration
                                                                .lineThrough
                                                            : null),
                                              ),
                                              trailing: Checkbox(
                                                onChanged: (newValue) async{
                                                        setState(() {
                                                    item.check = !item.check;

                                                  });
                                                  TaskServiceImp apiUpdate = TaskServiceImp();
                                              await apiUpdate.updateTask(state.tasks[index].id,item.check);
                                                  //put function
                                            
                                                },

                                                value: item.check,
                                                //  state.tasks[index].check,
                                                activeColor: Color.fromARGB(
                                                    255, 111, 134, 198),
                                              ),
                                              onTap: () {},
                                            );
                                          });
                                        }),
                                  ),
                                )
                              ]),
                        ),
                      );
                    } else if (state is Offline) {
                      return Center(
                        child: Text('No Internet'),
                      );
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      ));
                    }
                  },
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
