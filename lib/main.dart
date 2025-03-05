import 'package:flutter/material.dart';
import 'package:myles_todo/preload/splash_screen.dart';

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'models/task_controller.dart';
import 'package:myles_todo/pages/todo_list.dart';
import 'package:provider/provider.dart';
import 'pages/add_task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize Hive
  await Hive.initFlutter();

  //create a box for storage
  final box = await Hive.openBox('mybox');

  runApp(ChangeNotifierProvider(
    create: (context) => SaveTask(),
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      initialRoute: 'splash',
      routes: {
        'splash': (context) => SplashScreen(),
        'home': (context) => HomePage(),
        'addtask': (context) => AddTask(),
      },
      debugShowCheckedModeBanner: false,
    ),
  ));
}
