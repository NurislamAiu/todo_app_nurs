class Task {
  final String title;
  final String subtitle;
  final bool isDone;
  final List<Task> subTasks;

  Task({
    required this.title,
    this.subtitle = '',
    this.isDone = false,
    this.subTasks = const [],
  });

  // Метод для переключения статуса основной задачи
  Task toggleDone() {
    return Task(
      title: title,
      subtitle: subtitle,
      isDone: !isDone,
      subTasks: subTasks,
    );
  }

  // Метод для создания копии с изменениями (включая подзадачи)
  Task copyWith({String? title, String? subtitle, bool? isDone, List<Task>? subTasks}) {
    return Task(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isDone: isDone ?? this.isDone,
      subTasks: subTasks ?? this.subTasks,
    );
  }

  // Преобразование задачи в JSON (с подзадачами)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'isDone': isDone,
      'subTasks': subTasks.map((task) => task.toJson()).toList(),
    };
  }

  // Создание объекта Task из JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      subtitle: json['subtitle'],
      isDone: json['isDone'],
      subTasks: json['subTasks'] != null
          ? (json['subTasks'] as List).map((e) => Task.fromJson(e)).toList()
          : [],
    );
  }
}