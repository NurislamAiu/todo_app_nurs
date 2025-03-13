import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  void addTask(String title, String subtitle) {
    setState(() {
      tasks.add(Task(title: title, subtitle: subtitle)); // Добавлен subtitle
    });
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].toggleDone();
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do List')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: tasks[index],
            onToggle: () => toggleTask(index),
            onDelete: () => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String newTaskTitle = '';
          String newTaskSubtitle = '';
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Добавить задачу'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Название задачи'),
                      onChanged: (value) {
                        newTaskTitle = value;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Описание задачи'),
                      onChanged: (value) {
                        newTaskSubtitle = value;
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Отмена'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (newTaskTitle.isNotEmpty) {
                        addTask(newTaskTitle, newTaskSubtitle);
                      }
                      Navigator.pop(context);
                    },
                    child: Text('Добавить'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}