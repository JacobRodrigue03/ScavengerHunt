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
      appBar: AppBar(
        title: Text('Level $level'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
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
              /// ✅ This is the newly styled text box for "Explore Level $level"
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),  // Semi-transparent black box
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Explore Level $level',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 20),

              /// ✅ Location 1 Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LocationPage(level: level, locationNumber: 1),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(180, 50),
                ),
                child: const Text('Location 1'),
              ),

              const SizedBox(height: 12),

              /// ✅ Location 2 Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LocationPage(level: level, locationNumber: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(180, 50),
                ),
                child: const Text('Location 2'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
