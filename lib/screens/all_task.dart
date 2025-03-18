// Файл: all_tasks_screen.dart
import 'package:flutter/material.dart';

class AllTasksScreen extends StatelessWidget {
  AllTasksScreen({Key? key}) : super(key: key);

  // Список дней (пример)
  final List<String> weekdays = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  // Список дат (пример)
  final List<String> dates = [
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Фон можно настроить градиентом или светлым цветом
      backgroundColor: const Color(0xFFF9FAFB),

      // Верхняя панель
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        centerTitle: false,
        leading: const SizedBox(), // можно убрать или заменить на меню/назад
        title: const Text(
          'Sep 2020',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black54),
          ),
          const SizedBox(width: 8),
        ],
      ),

      // Плавающая кнопка добавления задачи
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF5967ff),
        onPressed: () {
          // Ваш колбэк
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Нижняя панель (по желанию)
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.white,
        child: SizedBox(
          height: 56.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.home, color: Colors.black54),
              Icon(Icons.person, color: Colors.black26),
            ],
          ),
        ),
      ),

      // Основное содержимое
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Горизонтальный список дат
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: weekdays.length,
                itemBuilder: (context, index) {
                  // Выделим, например, понедельник (index == 1) как выбранный
                  final bool isSelected = (index == 1);

                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weekdays[index],
                          style: TextStyle(
                            fontSize: 16,
                            color: isSelected ? Colors.white : Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF5967ff)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: isSelected
                                ? []
                                : [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              dates[index],
                              style: TextStyle(
                                fontSize: 18,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Заголовок для списка задач
            const Text(
              'Tasks',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // Список задач (пример)
            _buildTaskCard(
              icon: Icons.business_center_outlined,
              title: 'Project Meeting',
              time: '9 am to 11 am',
              iconBgColor: const Color(0xFFFCE6F2), // розоватый
              iconColor: const Color(0xFFfa82c0),
            ),
            _buildTaskCard(
              icon: Icons.phone_outlined,
              title: 'Client Call',
              time: '12 pm to 1 pm',
              iconBgColor: const Color(0xFFE2EEFF), // голубоватый
              iconColor: const Color(0xFF6E9EFF),
            ),
            _buildTaskCard(
              icon: Icons.people_outline,
              title: 'Team Meeting',
              time: '2 pm to 3 pm',
              iconBgColor: const Color(0xFFFFF4DD), // желтоватый
              iconColor: const Color(0xFFFFC23E),
            ),
            // Добавьте нужное количество карточек
          ],
        ),
      ),
    );
  }

  // Виджет карточки задачи
  Widget _buildTaskCard({
    required IconData icon,
    required String title,
    required String time,
    required Color iconBgColor,
    required Color iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          // Иконка
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),

          // Текст задачи
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          // Кнопка (три точки) - опционально
          IconButton(
            onPressed: () {
              // Меню или действие
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black26,
            ),
          ),
        ],
      ),
    );
  }
}