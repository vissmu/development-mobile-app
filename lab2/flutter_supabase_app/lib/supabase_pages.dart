import 'package:flutter/material.dart';
import 'supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseMenuPage extends StatelessWidget {
  const SupabaseMenuPage({super.key});

  Widget _btn(BuildContext ctx, String title, Widget page) => Container(
        width: 280,
        margin: const EdgeInsets.only(bottom: 12),
        child: FilledButton(
          onPressed: () =>
              Navigator.push(ctx, MaterialPageRoute(builder: (_) => page)),
          child: Text(title),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Supabase демо')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _btn(context, 'Обычный вариант (без realtime)',
                const EmotionsBasicPage()),
            _btn(context, 'Авто-обновление (stream)',
                const EmotionsStreamPage()),
            _btn(context, 'Сообщения (messages)', const MessagesPage()),
          ],
        ),
      ),
    );
  }
}

/// ===== Обычный вариант: ручное обновление =====
class EmotionsBasicPage extends StatefulWidget {
  const EmotionsBasicPage({super.key});
  @override
  State<EmotionsBasicPage> createState() => _EmotionsBasicPageState();
}

class _EmotionsBasicPageState extends State<EmotionsBasicPage> {
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = db.getEmotions();
  }

  Future<void> _refresh() async {
    setState(() => _future = db.getEmotions());
  }

  Future<void> _add() async {
    await db.addEmotion(
        title: 'Новая эмоция', description: 'Создано вручную', color: 'red');
    _refresh();
  }

  Future<void> _incViews(int id, int current) async {
    await db.updateEmotion(id: id, views: current + 1);
    _refresh();
  }

  Future<void> _delete(int id) async {
    await db.deleteEmotion(id);
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emotions — обычный вариант')),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) {
              return Center(
                  child: Text('Ошибка: ${snap.error}',
                      style: const TextStyle(color: Colors.red)));
            }
            final items = (snap.data ?? []) as List<Map<String, dynamic>>;
            if (items.isEmpty) {
              return const Center(child: Text('Пусто'));
            }
            return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final e = items[i];
                return ListTile(
                  title: Text('${e['title']} (${e['color']})'),
                  subtitle: Text(e['description'] ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('views: ${e['views'] ?? 0}  '),
                      IconButton(
                        icon: const Icon(Icons.remove_red_eye),
                        onPressed: () =>
                            _incViews(e['id'] as int, (e['views'] ?? 0) as int),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _delete(e['id'] as int),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

/// ===== Продвинутый вариант: авто-обновление (stream) =====
class EmotionsStreamPage extends StatelessWidget {
  const EmotionsStreamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stream = Supabase.instance.client
        .from('emotions')
        .stream(primaryKey: ['id'])
        .order('id');

    return Scaffold(
      appBar: AppBar(title: const Text('Emotions — авто-обновление')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await db.addEmotion(
              title: 'Stream эмоция',
              description: 'Создано через FAB',
              color: 'grey');
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: stream,
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = snap.data!;
          if (items.isEmpty) {
            return const Center(child: Text('Пусто (ожидаем записи)...'));
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final e = items[i];
              return ListTile(
                title: Text('${e['title']} (${e['color']})'),
                subtitle: Text(e['description'] ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('views: ${e['views'] ?? 0}  '),
                    IconButton(
                      icon: const Icon(Icons.remove_red_eye),
                      onPressed: () async {
                        final current = (e['views'] ?? 0) as int;
                        await db.updateEmotion(
                            id: e['id'] as int, views: current + 1);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await db.deleteEmotion(e['id'] as int);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// ===== Пример с messages (SELECT + INSERT) =====
class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});
  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final controller = TextEditingController();
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = db.getMessages();
  }

  Future<void> _send() async {
    final text = controller.text.trim();
    if (text.isEmpty) return;
    await db.addMessage(text);
    controller.clear();
    setState(() => _future = db.getMessages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration:
                        const InputDecoration(hintText: 'Введите сообщение...'),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(onPressed: _send, child: const Text('Send')),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _future,
              builder: (_, snap) {
                if (snap.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return Center(
                      child: Text('Ошибка: ${snap.error}',
                          style: const TextStyle(color: Colors.red)));
                }
                final items = (snap.data ?? []) as List<Map<String, dynamic>>;
                if (items.isEmpty) {
                  return const Center(child: Text('Нет сообщений'));
                }
                return ListView.separated(
                  reverse: true,
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, i) {
                    final m = items[i];
                    return ListTile(
                      title: Text(m['message_text'] ?? ''),
                      subtitle: Text('${m['created_at']}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
