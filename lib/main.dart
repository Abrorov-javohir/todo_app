import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_screen.dart'; // todo ma'lumotlarini yuklash uchun

void main() {
  runApp(MyApp());
}

// MyApp classida ChangeNotifierProvider bilan ishlaymiz
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: TodosScreen(),
      ),
    );
  }
}
