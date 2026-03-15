import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String _feedback = '';
  Color _feedbackColor = Colors.black;

  void _checkAnswer(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        _feedback = 'Bonne réponse !';
        _feedbackColor = Colors.green;
      } else {
        _feedback = 'Mauvaise réponse !';
        _feedbackColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Quiz'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Quelle est la capitale du Maroc ?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _checkAnswer(true),
                  child: const Text('Rabat'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _checkAnswer(false),
                  child: const Text('Casablanca'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _checkAnswer(false),
                  child: const Text('Marrakech'),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                _feedback,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _feedbackColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}