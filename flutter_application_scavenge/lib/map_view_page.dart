import 'package:flutter/material.dart';

class MapViewPage extends StatelessWidget {
  final String floor;

  const MapViewPage({super.key, required this.floor});

  String get _mapImage {
    switch (floor) {
      case '1':
        return 'assets/images/floor_1_pft.jpg';
      case '2':
        return 'assets/images/floor_2_pft.jpg';
      case '3':
        return 'assets/images/floor_3_pft.jpg';
      default:
        return 'assets/images/floor_1_pft.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map for Floor $floor'),
      ),
      body: Center(
        child: Image.asset(
          _mapImage,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
