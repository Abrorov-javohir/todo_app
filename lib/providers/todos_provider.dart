import 'package:dio/dio.dart';
import 'package:todo_app/model/todo.dart';

// Firebase URL bazasi
const String firebaseUrl = "https://todo-667d1-default-rtdb.firebaseio.com/todo1";

// Dio instansiyasi
final Dio dio = Dio();

// Firebase'dan ma'lumotlarni olish (READ)
Future<List<Todo>> getTodos() async {
  final response = await dio.get("$firebaseUrl.json");

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

// Firebase'ga yangi todo yaratish (CREATE)
Future<void> createTodo(Todo todo) async {
  try {
    final response = await dio.post(
      "$firebaseUrl.json",
      data: todo.toMap(),
    );
    print("Todo created: ${response.data}");
  } catch (e) {
    print("Error creating todo: $e");
  }
}

// Firebase'dagi todo'ni yangilash (UPDATE)
Future<void> updateTodo(Todo todo) async {
  try {
    final response = await dio.put(
      "$firebaseUrl/${todo.id}.json",
      data: todo.toMap(),
    );
    print("Todo updated: ${response.data}");
  } catch (e) {
    print("Error updating todo: $e");
  }
}

// Firebase'dagi todo'ni o'chirish (DELETE)
Future<void> deleteTodo(String id) async {
  try {
    final response = await dio.delete("$firebaseUrl/$id.json");
    print("Todo deleted: ${response.data}");
  } catch (e) {
    print("Error deleting todo: $e");
  }
}