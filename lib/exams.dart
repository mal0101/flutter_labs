import 'package:flutter/material.dart';
import 'database.dart';

class ExamsPage extends StatefulWidget {
  const ExamsPage({super.key});

  @override
  State<ExamsPage> createState() => _ExamsPageState();
}

class _ExamsPageState extends State<ExamsPage> {
  final DatabaseHelper _db = DatabaseHelper.instance;
  final TextEditingController _examController = TextEditingController();
  List<Map<String, dynamic>> _exams = [];

  @override
  void initState() {
    super.initState();
    _loadExams();
  }

  Future<void> _loadExams() async {
    final data = await _db.getExams();
    setState(() => _exams = data);
  }

  Future<void> _addExam() async {
    final name = _examController.text.trim();
    if (name.isEmpty) return;
    await _db.insertExam(name);
    _examController.clear();
    await _loadExams();
  }

  Future<void> _deleteExam(int id) async {
    await _db.deleteExam(id);
    await _loadExams();
  }

  Future<void> _showEditDialog(int id, String currentName) async {
    final controller = TextEditingController(text: currentName);
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Modifier l\'examen'),
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
                await _db.updateExam(id, newName);
                Navigator.pop(ctx);
                await _loadExams();
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
    _examController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestion des Examens')),
      body: Column(
        children: [
          // ── Input row ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _examController,
                    decoration: const InputDecoration(
                      labelText: 'Nom de l\'examen',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addExam(),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: _addExam,
                  icon: const Icon(Icons.add),
                  label: const Text('Ajouter'),
                ),
              ],
            ),
          ),
          // ── List ───────────────────────────────────────────────────────
          Expanded(
            child: _exams.isEmpty
                ? const Center(child: Text('Aucun examen enregistré.'))
                : ListView.separated(
              itemCount: _exams.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, index) {
                final exam = _exams[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal,
                    child: Text('${exam['id']}',
                        style:
                        const TextStyle(color: Colors.white)),
                  ),
                  title: Text(exam['exam_name'] as String),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        tooltip: 'Modifier',
                        onPressed: () => _showEditDialog(
                          exam['id'] as int,
                          exam['exam_name'] as String,
                        ),
                      ),
                      IconButton(
                        icon:
                        const Icon(Icons.delete, color: Colors.red),
                        tooltip: 'Supprimer',
                        onPressed: () =>
                            _deleteExam(exam['id'] as int),
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