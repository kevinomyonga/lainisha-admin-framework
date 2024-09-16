import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lainisha Admin Framework'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Lainisha Admin Framework',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Open documentation link
              },
              child: const Text('Documentation'),
            ),
            ElevatedButton(
              onPressed: () {
                // Open examples link
              },
              child: const Text('Examples'),
            ),
            ElevatedButton(
              onPressed: () {
                // Open community link
              },
              child: const Text('Community'),
            ),
          ],
        ),
      ),
    );
  }
}
