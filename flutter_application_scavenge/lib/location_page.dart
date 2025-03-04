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

  final Map<String, String> _correctKeywords = {
    'Level 1 - Location 1': 'keyword1a',
    'Level 1 - Location 2': 'keyword1b',
    'Level 2 - Location 1': 'keyword2a',
    'Level 2 - Location 2': 'keyword2b',
    'Level 3 - Location 1': 'keyword3a',
    'Level 3 - Location 2': 'keyword3b',
  };

  final Map<String, String> _funFacts = {
    'Level 1 - Location 1': 'Fun Fact: This place was built in 1920!',
    'Level 1 - Location 2': 'Fun Fact: This room once held a famous lecture.',
    // Add placeholders for the rest
  };

  String get _locationKey => 'Level ${widget.level} - Location ${widget.locationNumber}';

  void _checkKeyword() async {
    final enteredKeyword = _controller.text.trim().toLowerCase();
    final correctKeyword = _correctKeywords[_locationKey]?.toLowerCase();

    if (enteredKeyword == correctKeyword) {
      await _huntService.markLocationVisited(_locationKey);
      final funFact = _funFacts[_locationKey] ?? 'Fun Fact: You found it!';
      showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Success!'), content: Text(funFact), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))]));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Incorrect keyword. Try again!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_locationKey)),
      body: Column(
        children: [
          Text('Enter the keyword for $_locationKey'),
          TextField(controller: _controller),
          ElevatedButton(onPressed: _checkKeyword, child: const Text('Submit')),
        ],
      ),
    );
  }
}
