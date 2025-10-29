import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_pages.dart'; // ← файл с экранами Supabase

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1) Загружаем .env
  await dotenv.load(fileName: '.env');
  final url = dotenv.env['SUPABASE_URL']!;
  final anonKey = dotenv.env['SUPABASE_ANON_KEY']!;

  // 2) Инициализируем Supabase
  await Supabase.initialize(
    url: url,
    anonKey: anonKey,
  );

  print('[INIT] Supabase initialized with URL=$url');
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

/// Главная страница приложения с навигацией по четырём частям
class HomePage extends StatelessWidget {
  const HomePage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          'Темная пустота',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        ),
        backgroundColor: Colors.grey[850],
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavigationButton(
                title: 'Одиночество виджетов',
                color: Colors.grey[800]!,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FirstPart()),
                ),
              ),
              const SizedBox(height: 16),
              _buildNavigationButton(
                title: 'Бесполезные действия',
                color: Colors.grey[700]!,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SecondPart()),
                ),
              ),
              const SizedBox(height: 16),
              _buildNavigationButton(
                title: 'Бесконечный скролл',
                color: const Color(0xFF8B0000),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ThirdPart()),
                ),
              ),
              const SizedBox(height: 16),
              _buildNavigationButton(
                title: 'База данных (Supabase)',
                color: Colors.grey[850]!,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SupabaseMenuPage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// === СТАРЫЕ ЭКРАНЫ ===
/// (всё как у тебя — без изменений)
class FirstPart extends StatelessWidget {
  const FirstPart({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Одиночество виджетов'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildContainer('Пустота', 'Ничего не изменить', Colors.grey[800]!),
          _buildContainer('Боль', 'Всё проходит', const Color(0xFF8B0000)),
        ],
      ),
    );
  }

  Widget _buildContainer(String title, String subtitle, Color color) {
    return Container(
      width: 120,
      height: 120,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 8),
          Text(subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class SecondPart extends StatelessWidget {
  const SecondPart({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(title: const Text('Бесполезные действия')),
      body: const Center(child: Text('Содержимое второй части')),
    );
  }
}

class ThirdPart extends StatelessWidget {
  const ThirdPart({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(title: const Text('Бесконечный скролл')),
      body: const Center(child: Text('Содержимое третьей части')),
    );
  }
}
