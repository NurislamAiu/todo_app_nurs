class Task {
  String title;
  String subtitle; // Новое поле
  bool isDone;

  Task({required this.title, this.subtitle = '', this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}