import 'dart:io';

import 'package:flutter/material.dart';

import 'package:untitled4/todomodel.dart';
import 'home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //used to ensure that the Flutter framework is fully initialized before executing any code

  Directory directory =
      await getApplicationDocumentsDirectory(); //get the directory from the path_provider.

  Hive.registerAdapter(TodoAdapter());//to register adaptor
  Hive.init(directory.path);

  await Hive.openBox<Todo>('todoBox');

  runApp(const MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  const MyTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.amber),
      debugShowCheckedModeBanner: false,
      home: const SafeArea(child: HomeScreen()),
    );
  }
}
