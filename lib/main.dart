import 'package:flutter/material.dart';
import 'screens/exercice1.dart';
import 'screens/exercice2.dart';
import 'screens/exercice3.dart';
import 'screens/exercice4.dart';
import 'screens/exercice5.dart';
import 'screens/quiz.dart';
import 'database.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atelier Flutter',
      debugShowCheckedModeBanner: false,
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
      {
        'title': 'Exercice 1',
        'subtitle': 'Ma première application Flutter',
        'page': const Exercice1Page(),
        'isSpecial': false,
      },
      {
        'title': 'Exercice 2',
        'subtitle': 'Plusieurs widgets (Text, Image, Button)',
        'page': const Exercice2Page(),
        'isSpecial': false,
      },
      {
        'title': 'Exercice 3',
        'subtitle': 'Row, Column et boutons de couleur',
        'page': const Exercice3Page(),
        'isSpecial': false,
      },
      {
        'title': 'Exercice 4',
        'subtitle': 'Compteur de clics',
        'page': const Exercice4Page(),
        'isSpecial': false,
      },
      {
        'title': 'Exercice 5',
        'subtitle': 'Mini To-Do List',
        'page': const Exercice5Page(),
        'isSpecial': false,
      },
      {
        'title': 'Atelier 3',
        'subtitle': 'Liaison Flutter & Base de données — Gestion Étudiants',
        'page': const StudentsPage(),
        'isSpecial': false,
      },
      {
        'title': 'À Rendre',
        'subtitle': 'Mini Quiz — Capitale du Maroc',
        'page': const QuizPage(),
        'isSpecial': true,
      },
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
          final isSpecial = item['isSpecial'] as bool;
          return Card(
            color: isSpecial ? Colors.blue.shade50 : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: isSpecial
                  ? const BorderSide(color: Colors.blue, width: 1.5)
                  : BorderSide.none,
            ),
            child: ListTile(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(
                item['title'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isSpecial ? Colors.blue : Colors.black87,
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

// ─────────────────────────────────────────────────────────────────────────────

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  final DatabaseHelper _db = DatabaseHelper.instance;
  final TextEditingController _nameController = TextEditingController();
  List<Map<String, dynamic>> _students = [];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final data = await _db.getStudents();
    setState(() => _students = data);
  }

  Future<void> _addStudent() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    await _db.insertStudent(name);
    _nameController.clear();
    await _loadStudents();
  }

  Future<void> _deleteStudent(int id) async {
    await _db.deleteStudent(id);
    await _loadStudents();
  }

  Future<void> _showEditDialog(int id, String currentName) async {
    final controller = TextEditingController(text: currentName);
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Modifier l\'étudiant'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Nouveau nom'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () async {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                await _db.updateStudent(id, newName);
                Navigator.pop(ctx);
                await _loadStudents();
              }
            },
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestion des Étudiants')),
      body: Column(
        children: [
          // ── Input row ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nom de l\'étudiant',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addStudent(),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: _addStudent,
                  icon: const Icon(Icons.add),
                  label: const Text('Ajouter'),
                ),
              ],
            ),
          ),
          // ── List ───────────────────────────────────────────────────────
          Expanded(
            child: _students.isEmpty
                ? const Center(child: Text('Aucun étudiant enregistré.'))
                : ListView.separated(
              itemCount: _students.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, index) {
                final student = _students[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${student['id']}'),
                  ),
                  title: Text(student['name'] as String),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        tooltip: 'Modifier',
                        onPressed: () => _showEditDialog(
                          student['id'] as int,
                          student['name'] as String,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        tooltip: 'Supprimer',
                        onPressed: () =>
                            _deleteStudent(student['id'] as int),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}