import 'package:dio/dio.dart';
import 'package:todo_app/model/todo.dart';

// Firebase URL bazasi
const String firebaseUrl =
    "https://todo-667d1-default-rtdb.firebaseio.com/todo1";

// Dio instansiyasi
final Dio dio = Dio();

// Firebase'dan ma'lumotlarni olish (READ)
Future<List<Todo>> getTodos() async {
  try {
    final response = await dio.get("$firebaseUrl.json");

    // Check if response data is not null and is a Map
    if (response.data != null && response.data is Map<String, dynamic>) {
      final Map<String, dynamic> mapTodos =
          Map<String, dynamic>.from(response.data);
      List<Todo> todos = [];

      // Loop through mapTodos and convert each entry to a Todo object
      mapTodos.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          final map = Map<String, dynamic>.from(value);
          map['id'] = key; // Adding 'id' to each todo
          final todo = Todo.fromMap(map);
          todos.add(todo);
        }
      });

      return todos;
    } else {
      return []; // Return empty list if data is null or not a map
    }
  } catch (e) {
    // Error handling
    print('Error fetching todos: $e');
    return []; // Return empty list on error
  }
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
