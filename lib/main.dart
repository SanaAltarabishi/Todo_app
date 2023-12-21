import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/bloc/add_task_bloc.dart';
import 'package:todo/bloc/bloc/delete_task_bloc.dart';
import 'package:todo/bloc/bloc_observe.dart';
import 'package:todo/bloc/task_get_bloc.dart';
import 'package:todo/pages/show_add_task.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Color.fromARGB(255, 111, 134, 198)),
        home: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => AddTaskBloc(),
          ),
          BlocProvider(
            create: (context) => TaskGetBloc()..add(GetTask()),
          ),
          BlocProvider(
            create: (context) => DeleteTaskBloc(),
          )
        ], child: WelcomPage()
            // ShowAddTaskPage()
            // TaskPage(),
            ));
  }
}

// deleteItem(String id){
// String url  = 'dskajdskjklsdjklad/${id}';
// }

class WelcomPage extends StatelessWidget {
  const WelcomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/stars.jpg'), fit: BoxFit.fill),
        ),
        child: InkWell(
          onTap:() {
               Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>ShowAddTaskPage ()),
          );
          }, 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "WELCOME TO TODO APP",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              ),
              SizedBox(height: 10,),
              Text('write your todo and plane for your dreams',style: TextStyle(fontSize: 15,color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }
}
