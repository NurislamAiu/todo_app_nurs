import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // Основной цвет фона (светлый для неоморфизма)
  static const Color baseColor = Color(0xFFE0E5EC);

  // Пример данных для проектов (горизонтальный список)
  static const List<Map<String, String>> projects = [
    {
      'title': 'Project A',
      'subtitle': 'Front End Development',
      'date': 'September 2020',
    },
    {
      'title': 'Project B',
      'subtitle': 'Graphic Design',
      'date': 'October 2020',
    },
  ];

  // Пример данных для задач (вертикальный список) с цветом
  static const List<Map<String, dynamic>> tasks = [
    {
      'title': 'Project Name',
      'subtitle': '2 days ago',
      'color': Color(0xFFFFC3C3), // розоватый
    },
    {
      'title': 'Another Project',
      'subtitle': '5 days ago',
      'color': Color(0xFFCCE8CF), // зеленоватый
    },
    {
      'title': 'Design Concepts',
      'subtitle': '1 week ago',
      'color': Color(0xFFD9C3FF), // фиолетовый
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.8, -0.8),
            radius: 1.2,
            colors: [
              baseColor,
              baseColor.withOpacity(0.95),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNeumorphicSearchField(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildTabItem('My Task', isActive: true),
                        _buildTabItem('Projects', isActive: false),
                        _buildTabItem('Notes', isActive: true),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 180,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: projects.length,
                        separatorBuilder: (_, __) =>
                        const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final project = projects[index];
                          return _buildNeumorphicProjectCard(
                            context: context,
                            title: project['title']!,
                            subtitle: project['subtitle']!,
                            date: project['date']!,
                            color: Colors.blue.withOpacity(0.8),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Process',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return _buildColoredTaskTile(
                            title: task['title'] as String,
                            subtitle: task['subtitle'] as String,
                            color: task['color'] as Color,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              _buildNeumorphicBottomNav(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      actionsPadding: const EdgeInsets.all(15),
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: baseColor,
      title: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Text(
          'Have a nice day!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ),
      actions: [
        CircleAvatar(
          radius: 26,
          backgroundColor: Colors.transparent,
          child: IconButton(
            icon: const Icon(Icons.person, color: Colors.black54),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  // ПОЛЕ ПОИСКА (Search)
  Widget _buildNeumorphicSearchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.all(16),
      height: 50,
      decoration: _neumorphicDecoration(baseColor),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.black38),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                fillColor: Colors.transparent,
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.black38),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                // Логика поиска
              },
            ),
          ),
        ],
      ),
    );
  }

  // ВКЛАДКИ (Tabs)
  Widget _buildTabItem(String title, {required bool isActive}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? Colors.red : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black54,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  // КАРТОЧКИ ПРОЕКТОВ
  Widget _buildNeumorphicProjectCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String date,
    required Color color,
  }) {
    final double cardWidth =
    (MediaQuery.of(context).size.width * 0.4).clamp(150.0, 300.0).toDouble();
    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Иконка и заголовок проекта
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.6),
                      offset: const Offset(-2, -2),
                      blurRadius: 4,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.work_outline,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Text(
            date,
            style: const TextStyle(
              color: Colors.black38,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ЦВЕТНЫЕ КАРТОЧКИ ЗАДАЧ
  Widget _buildColoredTaskTile({
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          // Иконка задачи
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.8),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.6),
                  offset: const Offset(-2, -2),
                  blurRadius: 4,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: const Icon(
              Icons.description_outlined,
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.black38),
          ),
        ],
      ),
    );
  }

  // НЕОМОРФНАЯ ПАНЕЛЬ НАВИГАЦИИ
  Widget _buildNeumorphicBottomNav() {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: _neumorphicDecoration(baseColor, borderRadius: 20),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(Icons.home, isActive: true),
          _buildNavItem(Icons.calendar_month),
          _buildNavItem(Icons.notifications),
          _buildNavItem(Icons.person),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, {bool isActive = false}) {
    return Icon(
      icon,
      color: isActive ? const Color(0xFF6874E8) : Colors.black26,
      size: 28,
    );
  }

  BoxDecoration _neumorphicDecoration(Color color,
      {double borderRadius = 12}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.8),
          offset: const Offset(-4, -4),
          blurRadius: 8,
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: const Offset(4, 4),
          blurRadius: 8,
        ),
      ],
    );
  }
}