import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/providers/todos_provider.dart';
import 'package:todo_app/screens/todo_screen.dart'; // todo ma'lumotlarini yuklash uchun

void main() {
  runApp(MyApp());
}

// ChangeNotifier dan foydalanamiz, Riverpod o'rniga
class TodosNotifier extends ChangeNotifier {
  List<Todo> todos = [];
  bool isLoading = true;
  String errorMessage = '';

  // Ma'lumotlarni yuklash
  Future<void> fetchTodos() async {
    try {
      isLoading = true;
      notifyListeners(); // UI ni yangilash uchun

      todos = await getTodos(); // Firebase'dan ma'lumot olish
      isLoading = false;
    } catch (error) {
      errorMessage = 'Oops, something unexpected happened';
      isLoading = false;
    } finally {
      notifyListeners(); // UI ni yangilash uchun
    }
  }
}

// MyApp classida ChangeNotifierProvider bilan ishlaymiz
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          TodosNotifier()..fetchTodos(), // Ma'lumotlarni yuklash
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: const Text('Example')),
          body: TodosScreen(),
        ),
      ),
    );
  }
}
