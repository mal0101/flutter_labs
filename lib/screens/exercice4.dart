import 'package:flutter/material.dart';

class Exercice4Page extends StatefulWidget {
  const Exercice4Page({super.key});

  @override
  State<Exercice4Page> createState() => _Exercice4PageState();
}

class _Exercice4PageState extends State<Exercice4Page> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercice 4 Flutter'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nombre de clics : $_counter',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () => setState(() => _counter++),
              child: const Text('Cliquer ici'),
            ),
          ],
        ),
      ),
    );
  }
}