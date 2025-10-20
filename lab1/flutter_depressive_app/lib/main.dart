import 'package:flutter/material.dart';

/// Главный класс приложения
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

/// Главная страница приложения с навигацией
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
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Виджет "Пустота"
          Container(
            width: 120,
            height: 120,
            color: Colors.grey[800],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Пустота',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 1,
                  width: 40,
                  color: Colors.grey[500],
                ),
                SizedBox(height: 8),
                Text(
                  'Ничего не изменить',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          
          // Виджет "Боль"
          Container(
            width: 120,
            height: 120,
            color: Color(0xFF8B0000),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Боль',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 1,
                  width: 40,
                  color: Colors.grey[500],
                ),
                SizedBox(height: 8),
                Text(
                  'Всё проходит',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}