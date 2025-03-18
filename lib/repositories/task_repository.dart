import '../models/task.dart';

abstract class TaskRepository {
  List<Task> getAllTasks();
  void addTask(Task task);
  void updateTask(int index, Task task);
  void deleteTask(int index);
}

class InMemoryTaskRepository implements TaskRepository {
  final List<Task> _tasks = [];

  @override
  List<Task> getAllTasks() => _tasks;

  @override
  void addTask(Task task) {
    _tasks.add(task);
  }

  @override
  void updateTask(int index, Task task) {
    _tasks[index] = task;
  }

  @override
  void deleteTask(int index) {
    _tasks.removeAt(index);
  }
}