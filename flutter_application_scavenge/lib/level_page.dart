import 'package:flutter/material.dart';
import 'location_page.dart';

class LevelPage extends StatelessWidget {
  final String level;

  const LevelPage({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Level $level')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Explore Level $level', style: const TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          LocationPage(level: level, locationNumber: 1)),
                );
              },
              child: const Text('Location 1'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          LocationPage(level: level, locationNumber: 2)),
                );
              },
              child: const Text('Location 2'),
            ),
          ],
        ),
      ),
    );
  }
}
