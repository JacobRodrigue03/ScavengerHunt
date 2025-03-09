import 'package:flutter/material.dart';
import 'hunt_service.dart';

class LocationPage extends StatefulWidget {
  final String level;
  final int locationNumber;

  const LocationPage(
      {super.key, required this.level, required this.locationNumber});

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
    '3': [
      '3rd Story - School of EE and CS',
      '3rd Story - Bayport Technical Center'
    ],
  };

  final Map<String, List<List<String>>> _riddles = {
    "1": [
      [
        "1st Story - Panera",
        """At Panera, where you love to stay, 
            The sign in front calls out my name. 
            Steamed milk swirls in coffee’s embrace, 
            A creamy sip, a warm embrace. 
        
            What drink am I? ☕""",
        "Latte"
      ],
      [
        "1st Story - Auditorium",
        """By glass doors in the hallway near,
            Behind Capstone stairs, it becomes clear.
            A purple sign beholds my name,
            So all who see it may proclaim.
            That to the creation of building I donated with pride,
            My name is known in timber, far and wide.
      
            What Company I? 🌲""",
        "RoyOMartin"
      ],
    ],
    "2": [
      [
        "2nd Story - Student Gathering Space",
        """On the second floor with a staircase in rear
            all students in need may cometh here.
            I contain chairs and tables and sofas galore.
            Behind me is a glass wall where you can see much more.

            My donator's name is on a plaque in front.
            He goes by a nickname which may seem quite blunt.

            What is the nickname of the person who donated to me?
    """,
        "Bill",
      ],
      [
        "2nd Story - Robots",
        """Behind a glass wall, where robots reside,
            On the second floor, with others by his side.
            With a yellow name, shining bright,
            A ramp in front, ready to fight.

            Who is this robot, standing so near?
            His name is known to all who come here.

            What am I? 🤖""",
        "Toby",
      ]
    ],
    "3": [
      [
        "3rd Story - School of EE and CS",
        """On the third floor, where knowledge is king,
            A glass front office, many students it brings.
            Home to engineers and coders alike,
            Behind these walls, innovations strike.

            The room's name, where brilliance does reside,
            Is the School of Electrical Engineering and Computer Science Office, where minds collide.

            What is my room number?""",
        "3325",
      ],
      [
        "3rd Story - Bayport Technical Center",
        "",
        "1229",
      ]
    ],
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
    '1st Story - Panera':
        'Fun Fact: They serve over a thousand students every day!',
    '1st Story - Auditorium':
        'Fun Fact: RoyOMartin is one of the most successful manufacturers of wood products in the South!',
    '2nd Story - Student Gathering Space':
        'Fun Fact: This is one of the most popular spots for students to rest between classes and study with friends.',
    '2nd Story - Robots':
        'Every year Bengal Bots, a club that offers experience with different types of robots, hosts a battlebots event at PFT!',
    '3rd Story - School of EE and CS':
        'Fun fact: This is where many students can come to learn more about what Computer Science and Electrical Engineering has to offer.',
    '3rd Story - Bayport Technical Center':
        'Fun Fact: A multi-pass floating head can allow for fluids to pass through the tubes multiple times, increasing the heat transfer efficiency!',
  };

  String get _locationKey {
    final locationsOnLevel = _locations[widget.level] ?? [];
    if (widget.locationNumber > locationsOnLevel.length) {
      return 'Unknown Location';
    }
    return locationsOnLevel[
        widget.locationNumber - 1]; // locationNumber is 1-based
  }

  String get _thisRiddle {
    final riddleData = _riddles[widget.level]?[widget.locationNumber - 1];

    if (riddleData != null && riddleData.length > 2) {
      return riddleData[1]; // Return the riddle text
    }

    return 'Riddle not found!';
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
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'))
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Incorrect keyword. Try again!')));
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
            Text("""Enter the keyword for this riddle: $_locationKey:\n
            $_thisRiddle""", style: const TextStyle(fontSize: 18)),
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
