import 'package:flutter/material.dart';
import 'hunt_service.dart';
import 'level_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HuntService _huntService = HuntService();
  late Future<Map<String, bool>> _progress;

  @override
  void initState() {
    super.initState();
    _progress = _huntService.loadProgress();
  }

  void _refreshProgress() {
    setState(() {
      _progress = _huntService.loadProgress();
    });
  }

  Widget _buildLevelButton(String level) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => LevelPage(level: level)),
        ).then((_) => _refreshProgress());
      },
      child: Text('Explore Level $level'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scavenger Hunt')),
      body: FutureBuilder<Map<String, bool>>(
        future: _progress,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final progress = snapshot.data!;
          return Column(
            children: [
              const Text('Choose a level to explore:', style: TextStyle(fontSize: 20)),
              _buildLevelButton('1'),
              _buildLevelButton('2'),
              _buildLevelButton('3'),
              const Divider(),
              const Text('Progress:', style: TextStyle(fontSize: 20)),
              for (var location in progress.keys)
                ListTile(
                  title: Text(location),
                  trailing: progress[location]! ? const Icon(Icons.check, color: Colors.green) : const Icon(Icons.close, color: Colors.red),
                ),
            ],
          );
        },
      ),
    );
  }
}
