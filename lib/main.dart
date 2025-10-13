import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// 🔗 URL вашего проекта Supabase
const supabaseUrl = 'https://hogfvggthtmezcdatnhn.supabase.co';

// 🔑 Анонимный ключ (замените на ваш)
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhvZ2Z2Z2d0aHRtZXpjZGF0bmhuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjAxMTczMDIsImV4cCI6MjA3NTY5MzMwMn0.MrEc_6Yp0rdOXiwFLyQjfN-eTulhQlwSxathZBw0Ato'; // ← ЗАМЕНИТЕ!

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🚀 Инициализация Supabase
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Three Tabs Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Моё приложение'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Главная'),
              Tab(icon: Icon(Icons.person), text: 'Профиль'),
              Tab(icon: Icon(Icons.settings), text: 'Настройки'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomeTab(),
            ProfileTab(),
            SettingsTab(),
          ],
        ),
      ),
    );
  }
}

// Вкладка 1: Главная
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Добро пожаловать на главную вкладку!',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

// Вкладка 2: Профиль
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Это ваш профиль',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

// Вкладка 3: Настройки
class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Настройки приложения',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}