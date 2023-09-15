import 'package:hive/hive.dart';

part 'todomodel.g.dart';

@HiveType(typeId: 1)

class Todo {
  @HiveField(0)
  String title;
  @HiveField(1)
  bool isCompleted;

  Todo({required this.title, required this.isCompleted});
}

