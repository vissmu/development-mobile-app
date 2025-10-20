import 'package:flutter/material.dart';

/// Главный класс приложения
/// 
/// Приложение демонстрирует различные аспекты депрессивной тематики
/// через три основные части с разным функционалом
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Темная Пустота',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      home: const HomePage(),
    );
  }
}

/// Главная страница приложения с навигацией по трем частям
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          'Темная пустота',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        backgroundColor: Colors.grey[850],
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Кнопка для перехода к первой части
            _buildNavigationButton(
              title: 'Одиночество виджетов',
              color: Colors.grey[800]!,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FirstPart()),
                );
              },
            ),
            const SizedBox(height: 16),
            
            // Кнопка для перехода ко второй части
            _buildNavigationButton(
              title: 'Бесполезные действия',
              color: Colors.grey[700]!,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondPart()),
                );
              },
            ),
            const SizedBox(height: 16),
            
            // Кнопка для перехода к третьей части
            _buildNavigationButton(
              title: 'Бесконечный скролл',
              color: const Color(0xFF8B0000),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThirdPart()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Вспомогательный метод для создания кнопок навигации
  Widget _buildNavigationButton({
    required String title,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

/// Первая часть приложения - демонстрация базовых виджетов
class FirstPart extends StatelessWidget {
  const FirstPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          'Одиночество виджетов',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        backgroundColor: Colors.grey[850],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Виджет "Пустота"
          _buildEmotionalContainer(
            title: 'Пустота',
            subtitle: 'Ничего не изменить',
            color: Colors.grey[800]!,
          ),
          
          // Виджет "Боль"
          _buildEmotionalContainer(
            title: 'Боль',
            subtitle: 'Всё проходит',
            color: const Color(0xFF8B0000),
          ),
        ],
      ),
    );
  }

  /// Метод для создания контейнеров с эмоциональным содержанием
  Widget _buildEmotionalContainer({
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      width: 120,
      height: 120,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 1,
            width: 40,
            color: Colors.grey[500],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Вторая часть приложения - интерактивные элементы
class SecondPart extends StatelessWidget {
  const SecondPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          'Бесполезные действия',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        backgroundColor: Colors.grey[850],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
      ),
      body: Column(
        children: [
          // Первый Expanded с изображением из сети
          Expanded(
            child: Container(
              color: Colors.grey[850],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[800],
                      backgroundImage: const NetworkImage(
                        'https://static.wikia.nocookie.net/aesthetics/images/5/52/Dead_inside.jpg',
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey[600]!,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Пустота в глазах',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Второй Expanded с текстом
          Expanded(
            child: Container(
              color: Colors.grey[900],
              child: const Center(
                child: Text(
                  'Расширенная пустота\nничего не заполняет',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          
          // Третий Expanded с иконкой
          Expanded(
            child: Container(
              color: Colors.grey[800],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: const Color(0xFF8B0000),
                      child: const Icon(
                        Icons.heart_broken,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Разбитое сердце',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      
      // Плавающая кнопка действия
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDepressiveDialog(context);
        },
        backgroundColor: const Color(0xFF8B0000),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  /// Метод для показа диалогового окна
  void _showDepressiveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[800],
          title: const Text(
            'Зачем?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
          content: const Text(
            'Это действие ничего не изменит...\nВсё останется таким же бессмысленным.',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Понятно',
                style: TextStyle(
                  color: Color(0xFF8B0000),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Третья часть приложения - бесконечный скролл
class ThirdPart extends StatelessWidget {
  const ThirdPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          'Бесконечный скролл',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        backgroundColor: Colors.grey[850],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // Карточки с депрессивным контентом
            _buildDepressiveCard(
              title: 'Всё тленно',
              content: 'Ничто не вечно под луной\nВсё проходит, всё уходит',
              color: Colors.grey[800]!,
            ),
            _buildDepressiveCard(
              title: 'Боль существования',
              content: 'Рождаться больно, жить больно,\nумирать тоже больно',
              color: const Color(0xFF8B0000),
            ),
            _buildDepressiveCard(
              title: 'Одиночество',
              content: 'В толпе людей я так одинок,\nмой крик поглощает тишина',
              color: Colors.grey[700]!,
            ),
            
            // Генерация списка элементов для скролла
            for (int i = 0; i < 15; i++)
              _buildScrollItem(i),
            
            // Конец списка
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[600]!, width: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Конец списка... или начало нового?\nВсё циклично и бессмысленно',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Метод для создания карточек
  Widget _buildDepressiveCard({
    required String title,
    required String content,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.grey[600]!,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 1,
            color: Colors.grey[500],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[300],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  /// Метод для создания элементов списка
  Widget _buildScrollItem(int index) {
    // Список депрессивных фраз
    List<String> depressivePhrases = [
      'Еще один день...',
      'Время течет медленно',
      'Ничего не меняется',
      'Ожидание конца',
      'Тишина внутри',
      'Пустота вокруг',
      'Сны без сновидений',
      'Шёпот забытых слов',
      'Тени прошлого',
      'Эхо ушедшего',
      'Пыль воспоминаний',
      'Холод настоящего',
      'Туман будущего',
      'Разбитые мечты',
      'Угасшие надежды',
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: index % 3 == 0 ? Colors.grey[800] : Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey[700]!,
          width: 0.3,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            color: index % 4 == 0 ? const Color(0xFF8B0000) : Colors.grey[600],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              depressivePhrases[index % depressivePhrases.length],
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}