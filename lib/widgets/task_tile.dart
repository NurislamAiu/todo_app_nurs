import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle; // Переключение статуса основной задачи
  final VoidCallback onDelete; // Удаление основной задачи

  // Колбэки для работы с подзадачами:
  final void Function(Task subTask) onAddSubTask;
  final void Function(int subTaskIndex) onToggleSubTask;
  final void Function(int subTaskIndex) onDeleteSubTask;

  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onAddSubTask,
    required this.onToggleSubTask,
    required this.onDeleteSubTask,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: ExpansionTile(
        title: Row(
          children: [
            Checkbox(
              value: task.isDone,
              onChanged: (_) => onToggle(),
              shape: const CircleBorder(),
              activeColor: Colors.teal,
            ),
            Expanded(
              child: Text(
                task.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: task.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ],
        ),
        subtitle: task.subtitle.isNotEmpty
            ? Text(
          task.subtitle,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        )
            : null,
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: onDelete,
        ),
        children: [
          // Вывод подзадач
          ...task.subTasks.asMap().entries.map((entry) {
            final subTaskIndex = entry.key;
            final subTask = entry.value;
            return ListTile(
              contentPadding: const EdgeInsets.only(left: 40, right: 16),
              leading: Checkbox(
                value: subTask.isDone,
                onChanged: (_) => onToggleSubTask(subTaskIndex),
                shape: const CircleBorder(),
                activeColor: Colors.teal,
              ),
              title: Text(
                subTask.title,
                style: TextStyle(
                  fontSize: 16,
                  decoration: subTask.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () => onDeleteSubTask(subTaskIndex),
              ),
            );
          }).toList(),
          // Строка для добавления новой подзадачи
          ListTile(
            contentPadding: const EdgeInsets.only(left: 40, right: 16),
            title: TextButton.icon(
              onPressed: () async {
                final newSubTaskTitle = await showDialog<String>(
                  context: context,
                  builder: (context) {
                    final controller = TextEditingController();
                    return AlertDialog(
                      title: const Text('Новая подзадача'),
                      content: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          labelText: 'Название подзадачи',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Отмена'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, controller.text.trim());
                          },
                          child: const Text('Добавить'),
                        ),
                      ],
                    );
                  },
                );
                if (newSubTaskTitle != null && newSubTaskTitle.isNotEmpty) {
                  onAddSubTask(Task(title: newSubTaskTitle));
                }
              },
              icon: const Icon(Icons.add, color: Colors.teal),
              label: const Text('Добавить подзадачу',
                  style: TextStyle(color: Colors.teal)),
            ),
          ),
        ],
      ),
    );
  }
}