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