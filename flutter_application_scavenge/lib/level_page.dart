import 'package:flutter/material.dart';
import 'location_page.dart';

class LevelPage extends StatelessWidget {
  final String level;

  const LevelPage({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    // Get the map image path based on the level
    String _mapImage;
    switch (level) {
      case '1':
        _mapImage = 'assets/images/floor_1_pft.jpg';
        break;
      case '2':
        _mapImage = 'assets/images/floor_2_pft.jpg';
        break;
      case '3':
        _mapImage = 'assets/images/floor_3_pft.jpg';
        break;
      default:
        _mapImage = 'assets/images/floor_1_pft.jpg';
        break;
    }

    return Scaffold(
      appBar: AppBar(title: Text('Level $level')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_mapImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Explore Level $level',
                  style: const TextStyle(fontSize: 24)),
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
      ),
    );
  }
}
