import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

/// Универсальные методы по трём таблицам.
/// Все действия логируются через print.
class DbService {
  // ===== EMOTIONS =====
  Future<List<Map<String, dynamic>>> getEmotions() async {
    try {
      print('[SELECT] emotions');
      final data = await supabase.from('emotions').select().order('id');
      print('[SELECT OK] emotions count=${data.length}');
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print('[SELECT ERROR] emotions => $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> addEmotion({
    required String title,
    String? description,
    String color = 'grey',
  }) async {
    try {
      print('[INSERT] emotions {title:$title, color:$color}');
      final inserted = await supabase.from('emotions').insert({
        'title': title,
        'description': description,
        'color': color,
      }).select().single();
      print('[INSERT OK] emotions id=${inserted['id']}');
      return Map<String, dynamic>.from(inserted);
    } catch (e) {
      print('[INSERT ERROR] emotions => $e');
      rethrow;
    }
  }

  Future<void> updateEmotion({
    required int id,
    String? title,
    String? description,
    String? color,
    int? views,
  }) async {
    try {
      print('[UPDATE] emotions id=$id');
      final payload = <String, dynamic>{};
      if (title != null) payload['title'] = title;
      if (description != null) payload['description'] = description;
      if (color != null) payload['color'] = color;
      if (views != null) payload['views'] = views;

      await supabase.from('emotions').update(payload).eq('id', id);
      print('[UPDATE OK] emotions id=$id');
    } catch (e) {
      print('[UPDATE ERROR] emotions id=$id => $e');
      rethrow;
    }
  }

  Future<void> deleteEmotion(int id) async {
    try {
      print('[DELETE] emotions id=$id');
      await supabase.from('emotions').delete().eq('id', id);
      print('[DELETE OK] emotions id=$id');
    } catch (e) {
      print('[DELETE ERROR] emotions id=$id => $e');
      rethrow;
    }
  }

  // ===== MESSAGES =====
  Future<List<Map<String, dynamic>>> getMessages() async {
    try {
      print('[SELECT] messages');
      final data =
          await supabase.from('messages').select().order('id', ascending: false);
      print('[SELECT OK] messages count=${data.length}');
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print('[SELECT ERROR] messages => $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> addMessage(String text) async {
    try {
      print('[INSERT] messages "$text"');
      final row = await supabase
          .from('messages')
          .insert({'message_text': text}).select().single();
      print('[INSERT OK] messages id=${row['id']}');
      return Map<String, dynamic>.from(row);
    } catch (e) {
      print('[INSERT ERROR] messages => $e');
      rethrow;
    }
  }

  // ===== THOUGHTS =====
  Future<List<Map<String, dynamic>>> getThoughts() async {
    try {
      print('[SELECT] thoughts');
      final data = await supabase.from('thoughts').select().order('id');
      print('[SELECT OK] thoughts count=${data.length}');
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print('[SELECT ERROR] thoughts => $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> addThought(String title, String content) async {
    try {
      print('[INSERT] thoughts {title:$title}');
      final row = await supabase
          .from('thoughts')
          .insert({'title': title, 'content': content}).select().single();
      print('[INSERT OK] thoughts id=${row['id']}');
      return Map<String, dynamic>.from(row);
    } catch (e) {
      print('[INSERT ERROR] thoughts => $e');
      rethrow;
    }
  }
}

final db = DbService();
