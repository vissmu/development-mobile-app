# Темная Пустота - Лабораторная работа 1

Flutter приложение, демонстрирующее аспекты депрессивной тематики.

## Структура приложения

- **Часть 1**: Одиночество виджетов - базовые виджеты Row, Container, Column, Text
- **Часть 2**: Бесполезные действия - интерактивные элементы FloatingActionButton, CircleAvatar, NetworkImage
- **Часть 3**: Бесконечный скролл - прокрутка SingleChildScrollView с декорациями

## Запуск проекта

```bash
flutter pub get
flutter run -d chrome
```

# 🌑 Темная Пустота — Лабораторная работа 2

Flutter-приложение, демонстрирующее депрессивную тематику и работу с облачной базой данных **Supabase**.  
Приложение объединяет визуальные элементы Flutter и сетевое взаимодействие (`select`, `insert`, `update`, `delete`), а также работу с real-time стримами.

---

## 📁 Структура проекта

### **Основные части приложения**

1. **Одиночество виджетов**  
   Демонстрация базовых компонентов Flutter (`Row`, `Container`, `Text`, `Column`).

2. **Бесполезные действия**  
   Использование интерактивных элементов (`FloatingActionButton`, `AlertDialog`, `CircleAvatar`, `NetworkImage`).

3. **Бесконечный скролл**  
   Вертикальный список с элементами и декоративными карточками (`SingleChildScrollView`).

4. **База данных (Supabase)**  
   Работа с удалённой БД через API Supabase. Реализованы:
   - **Обычный вариант** — ручное обновление (`select`, `insert`, `update`, `delete`);
   - **Продвинутый вариант (stream)** — автоматическое обновление списка через real-time-стрим;
   - **Messages-демо** — простая форма отправки и отображения сообщений.

---

## 🗃️ Структура базы данных Supabase

В проекте используются три таблицы:

### `emotions`
| Поле | Тип | Описание |
|------|-----|-----------|
| `id` | SERIAL (PK) | Идентификатор |
| `title` | TEXT | Название эмоции |
| `description` | TEXT | Краткое описание |
| `color` | TEXT | Цветовая метка (по умолчанию — `'grey'`) |
| `views` | INTEGER | Счётчик просмотров |
| `created_at` | TIMESTAMP | Время создания |

### `messages`
| Поле | Тип | Описание |
|------|-----|-----------|
| `id` | SERIAL (PK) | Идентификатор |
| `message_text` | TEXT | Текст сообщения |
| `created_at` | TIMESTAMP | Время отправки |

### `thoughts`
| Поле | Тип | Описание |
|------|-----|-----------|
| `id` | SERIAL (PK) | Идентификатор |
| `title` | TEXT | Заголовок мысли |
| `content` | TEXT | Содержание |
| `created_at` | TIMESTAMP | Время создания |

---

## 🔑 Настройка Supabase

1. Зарегистрируй проект на [https://supabase.com](https://supabase.com)  
2. Создай таблицы с помощью SQL:

   ```sql
   CREATE TABLE emotions (
     id SERIAL PRIMARY KEY,
     title TEXT NOT NULL,
     description TEXT,
     color TEXT DEFAULT 'grey',
     views INTEGER DEFAULT 0,
     created_at TIMESTAMP DEFAULT NOW()
   );

   CREATE TABLE messages (
     id SERIAL PRIMARY KEY,
     message_text TEXT NOT NULL,
     created_at TIMESTAMP DEFAULT NOW()
   );

   CREATE TABLE thoughts (
     id SERIAL PRIMARY KEY,
     title TEXT NOT NULL,
     content TEXT NOT NULL,
     created_at TIMESTAMP DEFAULT NOW()
   );
   ```

3. Добавь тестовые данные (для проверки CRUD):

   ```sql
   INSERT INTO emotions (title, description, color) VALUES 
   ('Пустота', 'Ничего не изменить', 'grey'),
   ('Боль', 'Всё проходит', 'red');

   INSERT INTO thoughts (title, content) VALUES 
   ('Еще один день...', 'Время течет медленно'),
   ('Ничего не меняется', 'Ожидание конца');
   ```

4. Включи **RLS (Row Level Security)** и создай политики:

   ```sql
   CREATE POLICY "Allow all operations" ON emotions FOR ALL USING (true);
   CREATE POLICY "Allow all operations" ON messages FOR ALL USING (true);
   CREATE POLICY "Allow all operations" ON thoughts FOR ALL USING (true);
   ```

---

## ⚙️ Настройка проекта Flutter

1. Установи зависимости:

   ```bash
   flutter pub get
   ```

2. Добавь файл `.env` в корень проекта:

   ```ini
   SUPABASE_URL=https://<project-ref>.supabase.co
   SUPABASE_ANON_KEY=<your-anon-public-key>
   ```

3. В `pubspec.yaml` пропиши:

   ```yaml
   dependencies:
     supabase_flutter: ^2.6.0
     flutter_dotenv: ^5.1.0

   flutter:
     uses-material-design: true
     assets:
       - .env
   ```

4. Инициализация Supabase выполнена в `main.dart`:

   ```dart
   await Supabase.initialize(
     url: dotenv.env['SUPABASE_URL']!,
     anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
   );
   ```

---

## 🚀 Запуск проекта

```bash
flutter run -d chrome
```

После запуска:
- Открой раздел **“База данных (Supabase)”**;
- Выбери нужный режим:
  - **Обычный вариант** — вручную обновляется через pull-to-refresh и кнопки;
  - **Авто-обновление (stream)** — данные появляются и исчезают в реальном времени;
  - **Messages** — можно вводить и отправлять сообщения.

---

## 🧩 Используемые технологии

- **Flutter** — фреймворк для кроссплатформенной разработки;  
- **Supabase** — облачная база данных и real-time API;  
- **Dart** — язык программирования;  
- **flutter_dotenv** — загрузка `.env` переменных;  
- **Material 3** — современная тёмная тема интерфейса.

---

## 🧠 Вывод

В ходе лабораторной работы:
- Реализовано подключение Flutter-приложения к Supabase;
- Добавлены операции `select`, `insert`, `update`, `delete` с логированием;
- Настроен поток real-time обновлений;
- Создана структура БД и настроены политики доступа;
- Объединены визуальные и сетевые компоненты в одном приложении.
