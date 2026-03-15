import 'package:flutter/material.dart';

class Exercice2Page extends StatelessWidget {
  const Exercice2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercice 2 Flutter'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenue à Flutter',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            Image.network(
              'https://storage.googleapis.com/cms-storage-bucket/6e19fee6b47b36ca613f.png',
              width: 150,
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.flutter_dash, size: 100, color: Colors.blue);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Bouton cliqué !');
              },
              child: const Text('Appuyez ici'),
            ),
          ],
        ),
      ),
    );
  }
}