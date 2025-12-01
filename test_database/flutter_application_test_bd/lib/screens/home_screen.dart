import 'package:flutter/material.dart';

import '../supabase_client.dart';
import 'auth_gate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<String> _loadUsername() async {
    final user = supabase.auth.currentUser;
    if (user == null) return 'неизвестный';

    try {
      final profile = await supabase
          .from('profiles')
          .select('username')
          .eq('id', user.id)
          .maybeSingle();

      if (profile == null) return user.email ?? 'неизвестный';
      return profile['username'] as String;
    } catch (_) {
      return user.email ?? 'неизвестный';
    }
  }

  Future<void> _logout(BuildContext context) async {
    await supabase.auth.signOut();

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const AuthGate()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
        actions: [
          IconButton(
            onPressed: () async => _logout(context),
            icon: const Icon(Icons.logout),
            tooltip: 'Выйти',
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _loadUsername(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Ошибка: ${snapshot.error}');
            }

            final username = snapshot.data ?? 'неизвестный';
            return Text(
              'Здравствуйте, $username',
              style: const TextStyle(fontSize: 24),
            );
          },
        ),
      ),
    );
  }
}
