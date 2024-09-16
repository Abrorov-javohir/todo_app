// Ma'lumotlarni ekranga chiqaradigan screen
import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/providers/todos_provider.dart';

class TodosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TodosNotifierdan ma'lumotlarni olamiz
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final titleController = TextEditingController();
              final _descriptionController = TextEditingController();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Yangi Todo'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(labelText: 'Sarlavha'),
                        ),
                        TextField(
                          controller: _descriptionController,
                          decoration: InputDecoration(labelText: 'Tavsif'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Bekor qilish'),
                      ),
                      TextButton(
                        onPressed: () async {
                          final newTodo = Todo(
                            title: titleController.text,
                            id: _descriptionController.text,
                            dateTime: DateTime.now(),
                            isDone: false,
                          );
                          await createTodo(
                              newTodo); // Firebase'ga yangi todo yaratish
                          Navigator.of(context).pop();
                        },
                        child: Text('Qo\'shish'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: FutureBuilder<List<Todo>>(
        future: getTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print("================");
            print(snapshot.error);
            return Center(
              child: Text("Xatolik yuz berdi: ${snapshot.hasError}"),
            );
          } else {
            final todos = snapshot.data!;
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.id),
                  trailing: IconButton(
                    onPressed: () async {
                      await deleteTodo(todo.id); // Todo'ni o'chirish
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Todo o\'chirildi'),
                      ));
                    },
                    icon: Icon(
                      Icons.delete,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
