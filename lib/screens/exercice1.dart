import 'package:flutter/material.dart';

class Exercice1Page extends StatelessWidget {
  const Exercice1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma première application flutter'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text(
                'Hello Flutter',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Clique ici'),
            ),
          ),
        ],
      ),
    );
  }
}