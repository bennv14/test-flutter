import 'package:flutter/material.dart';
import 'package:test/result_screen.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ResultScreen()),
            );
          },
          child: const Text('Next'),
        ),
      ),
    );
  }
}
