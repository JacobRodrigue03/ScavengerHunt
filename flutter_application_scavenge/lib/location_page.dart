import 'package:flutter/material.dart';
import 'hunt_service.dart';

class LocationPage extends StatefulWidget {
  final String level;
  final int locationNumber;

  const LocationPage({super.key, required this.level, required this.locationNumber});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final _controller = TextEditingController();
  final HuntService _huntService = HuntService();

  // This map links the numeric locationNumber to actual named locations for each level.
  final Map<String, List<String>> _locations = {
    '1': ['1st Story - Panera', '1st Story - Auditorium'],
    '2': ['2nd Story - Student Gathering Space', '2nd Story - Robots'],
    '3': ['3rd Story - School of EE and CS', '3rd Story - Bayport Technical Center'],
  };

  final Map<String, String> _correctKeywords = {
    '1st Story - Panera': 'Latte',
    '1st Story - Auditorium': 'RoyOMartin',
    '2nd Story - Student Gathering Space': 'Bill',
    '2nd Story - Robots': 'Toby',
    '3rd Story - School of EE and CS': '3325',
    '3rd Story - Bayport Technical Center': '1229',
  };

  final Map<String, String> _funFacts = {
    '1st Story - Panera': 'Fun Fact: They serve over a thousand students every day!',
    '1st Story - Auditorium': 'Fun Fact: RoyOMartin is one of the most successful manufacturers of wood products in the South!',
    '2nd Story - Student Gathering Space': 'Fun Fact: This is one of the most popular spots for students to rest between classes and study with friends.',
    '2nd Story - Robots': 'Every year Bengal Bots, a club that offers experience with different types of robots, hosts a battlebots event at PFT!',
    '3rd Story - School of EE and CS': 'Fun fact: This is where many students can come to learn more about what Computer Science and Electrical Engineering has to offer.',
    '3rd Story - Bayport Technical Center': 'Fun Fact: A multi-pass floating head can allow for fluids to pass through the tubes multiple times, increasing the heat transfer efficiency!',
  };

  String get _locationKey {
    final locationsOnLevel = _locations[widget.level] ?? [];
    if (widget.locationNumber > locationsOnLevel.length) {
      return 'Unknown Location';
    }
    return locationsOnLevel[widget.locationNumber - 1];  // locationNumber is 1-based
  }

  void _checkKeyword() async {
    final enteredKeyword = _controller.text.trim().toLowerCase();
    final correctKeyword = _correctKeywords[_locationKey]?.toLowerCase();

    if (enteredKeyword == correctKeyword) {
      await _huntService.markLocationVisited(_locationKey);
      final funFact = _funFacts[_locationKey] ?? 'You found it!';
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Success!'),
          content: Text(funFact),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Incorrect keyword. Try again!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_locationKey)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter the keyword for $_locationKey:', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter keyword',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkKeyword,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
