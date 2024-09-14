import 'package:dio/dio.dart';
import 'package:todo_app/model/todo.dart';

Future<List<Todo>> getTodos() async {
  final dio = Dio();
  final response = await dio
      .get("https://todo-667d1-default-rtdb.firebaseio.com/todo1.json");

  print("--------------------------------------------------${response}");

  // Firebase ma'lumotlarini qayta ishlash
  final Map<String, dynamic> mapTodos = response.data;
  List<Todo> todos = [];

  // Ma'lumotlarni loop orqali qayta ishlash va Todo obyektiga aylantirish
  mapTodos.forEach((key, value) {
    final map = value as Map<String, dynamic>;
    map['id'] = key; // har bir todo uchun id qo'shish
    final todo = Todo.fromMap(map);
    todos.add(todo);
  });

  return todos;
}
