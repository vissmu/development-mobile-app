# Flutter + Supabase Auth Demo

Небольшое веб-приложение на Flutter с авторизацией через Supabase.

## Функционал

- Регистрация:
  - Логин
  - Email
  - Пароль
- Вход:
  - по логину или email + пароль
- При регистрации и входе:
  - на почту отправляется одноразовый код (OTP)
  - после ввода кода выполняется авторизация
- После входа пользователь видит сообщение:
  "Здравствуйте, <логин>"
- Кнопка «Выйти» завершает сессию и возвращает на экран логина.

## Стек технологий

- Flutter (web)
- supabase_flutter
- flutter_dotenv
- Supabase Auth + Postgres

## Настройка Supabase

1. Включить Email Auth
   Открыть: Authentication → Providers → Email
   Включить: Enable Email provider

2. Создать таблицу profles
   Открыть: SQL → New Query
   Выполнить:

   create table public.profiles (
     id uuid primary key references auth.users(id) on delete cascade,
     username text unique not null,
     email text not null
   );

3. Отключить RLS
   Table Editor → profiles
   Должно быть: RLS disabled

4. Настроить шаблон письма с кодом OTP
   Authentication → Email Templates → Sign In (Email OTP)
   Использовать такой шаблон:

   <h2>Код для входа</h2>
   <p>Пожалуйста, введите этот код в приложении:</p>
   <p><strong>{{ .Token }}</strong></p>
   <p>Код действует 60 минут.</p>

   Важно: {{ .Token }} — именно одноразовый код (не magic link)

## Конфигурация .env

В корне проекта создать файл .env:

SUPABASE_URL=https://<project-ref>.supabase.co
SUPABASE_ANON_KEY=<your-anon-public-key>

Пример для репозитория (.env.example):

SUPABASE_URL=https://YOUR-PROJECT.supabase.co
SUPABASE_ANON_KEY=YOUR-ANON-KEY

Файл .env добавить в .gitignore.

## Структура проекта

lib/
  main.dart              — загрузка .env + инициализация Supabase
  supabase_client.dart   — общий клиент Supabase
  screens/
    auth_gate.dart       — выбирает экран входа или главную
    login_screen.dart    — вход (логин/email + пароль)
    register_screen.dart — регистрация
    otp_screen.dart      — подтверждение кода
    home_screen.dart     — "Здравствуйте, <логин>"

## Запуск

flutter pub get
flutter run -d chrome

Приложение откроется в браузере автоматически.
