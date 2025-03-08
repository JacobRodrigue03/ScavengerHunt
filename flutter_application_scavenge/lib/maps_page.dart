import 'package:flutter/material.dart';
import 'map_view_page.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patrick F. Taylor Hall Maps'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MapViewPage(floor: '1')),
                );
              },
              child: const Text('View 1st Floor Map'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MapViewPage(floor: '2')),
                );
              },
              child: const Text('View 2nd Floor Map'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MapViewPage(floor: '3')),
                );
              },
              child: const Text('View 3rd Floor Map'),
            ),
          ],
        ),
      ),
    );
  }
}
