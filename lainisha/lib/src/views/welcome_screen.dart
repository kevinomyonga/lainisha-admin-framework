import 'package:flutter/material.dart';

/// A stateless widget that displays a welcome screen for the Lainisha Admin
/// Framework. It includes buttons for navigating to documentation, examples,
/// and community resources.
class WelcomeScreen extends StatelessWidget {
  /// Creates a [WelcomeScreen] widget.
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
              onPressed: () {},
              child: const Text('Documentation'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Examples'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Community'),
            ),
          ],
        ),
      ),
    );
  }
}
