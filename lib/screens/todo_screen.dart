// Ma'lumotlarni ekranga chiqaradigan screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/main.dart';

class TodosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TodosNotifierdan ma'lumotlarni olamiz
    return Scaffold(
      body: Consumer<TodosNotifier>(
        builder: (context, notifier, child) {
          if (notifier.isLoading) {
            return const Center(
                child: CircularProgressIndicator()); // Yuklanayotgan bo'lsa
          }
          if (notifier.errorMessage.isNotEmpty) {
            return Center(child: Text(notifier.errorMessage)); // Xatolik bo'lsa
          }
          return ListView.builder(
            itemCount: notifier.todos.length,
            itemBuilder: (context, index) {
              final malumot = notifier.todos[index];
              return ListTile(
                title: Text('Title: ${malumot.title}'),
                subtitle: Text('Date: ${malumot.dateTime}'),
              );
            },
          );
        },
      ),
    );
  }
}
