import 'package:flutter/material.dart';
import 'screens/exercice1.dart';
import 'screens/exercice2.dart';
import 'screens/exercice3.dart';
import 'screens/exercice4.dart';
import 'screens/exercice5.dart';
import 'screens/quiz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atelier Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _navigate(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final exercises = [
      {'title': 'Exercice 1', 'subtitle': 'Ma première application Flutter', 'page': const Exercice1Page()},
      {'title': 'Exercice 2', 'subtitle': 'Plusieurs widgets (Text, Image, Button)', 'page': const Exercice2Page()},
      {'title': 'Exercice 3', 'subtitle': 'Row, Column et boutons de couleur', 'page': const Exercice3Page()},
      {'title': 'Exercice 4', 'subtitle': 'Compteur de clics', 'page': const Exercice4Page()},
      {'title': 'Exercice 5', 'subtitle': 'Mini To-Do List', 'page': const Exercice5Page()},
      {'title': 'À Rendre', 'subtitle': 'Mini Quiz — Capitale du Maroc', 'page': const QuizPage()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Atelier Flutter'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = exercises[index];
          final isQuiz = index == exercises.length - 1;
          return Card(
            color: isQuiz ? Colors.blue.shade50 : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: isQuiz
                  ? const BorderSide(color: Colors.blue, width: 1.5)
                  : BorderSide.none,
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(
                item['title'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isQuiz ? Colors.blue : Colors.black87,
                ),
              ),
              subtitle: Text(item['subtitle'] as String),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _navigate(context, item['page'] as Widget),
            ),
          );
        },
      ),
    );
  }
}