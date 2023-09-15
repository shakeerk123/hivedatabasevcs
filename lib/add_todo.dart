import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled4/todomodel.dart';
import 'colors.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController todoController = TextEditingController();
  Box todoBox = Hive.box<Todo>('todoBox');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgcolor,
        appBar: AppBar(
          title: const Center(
            child: Text('ADD TODO'),
          ),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                controller: todoController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            ElevatedButton(
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (todoController.text != '') {
                    var todo =
                        Todo(title: todoController.text, isCompleted: false);
                    todoBox.add(todo);
                    Navigator.pop(context);
                    todoController.clear();
                  } else if (todoController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Add some Text'),
                      ),
                    );
                  }
                })
          ]),
        ),
      ),
    );
  }
}
