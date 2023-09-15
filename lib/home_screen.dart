import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled4/todomodel.dart';
import 'add_todo.dart';
import 'colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController todoController = TextEditingController();
  Box todoBox = Hive.box<Todo>('todoBox');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        shape:const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(30),top: Radius.circular(30))),
        title: const Center(child: Text("Hive Todo List")),
      ),
      body: ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        builder: (context, Box box, widget) {
          if (box.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'No Todo',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: todoBox.length,
                itemBuilder: (context, index) {
                  Todo todo = todoBox.getAt(index); //get the value from an index created

                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.amber.shade300),
                    child: ListTile(
                      title: Text(
                        todo.title,
                        style:  TextStyle(
                            decoration: todo.isCompleted? TextDecoration.lineThrough:TextDecoration.none,
                            color: todo.isCompleted? Colors.black:Colors.green,
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          todoBox.deleteAt(index);

                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(' Todo Deleted Successfully')));
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      leading: Checkbox(
                        value: todo.isCompleted,
                        onChanged: (value) {
                          Todo newTodo = Todo(
                            title: todo.title,
                            isCompleted: value!,
                          );

                          box.putAt(index, newTodo);
                        },
                      ),

                    ),

                  );
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTodo()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
