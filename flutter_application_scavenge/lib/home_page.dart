import 'package:flutter/material.dart';
import 'hunt_service.dart';
import 'level_page.dart';
import 'maps_page.dart';

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

  Widget _buildLevelCard(String level, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, size: 36, color: Colors.blueAccent),
        title: Text('Explore Level $level', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => LevelPage(level: level)),
          ).then((_) => _refreshProgress());
        },
      ),
    );
  }

  Widget _buildProgressSection(Map<String, bool> progress) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your Progress', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...progress.keys.map((location) {
              final completed = progress[location] ?? false;
              return Row(
                children: [
                  Icon(
                    completed ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: completed ? Colors.green : Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(location, style: const TextStyle(fontSize: 16)),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMapsButton() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.blueAccent,
      child: ListTile(
        leading: const Icon(Icons.map, size: 36, color: Colors.white),
        title: const Text(
          'View Building Maps',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MapsPage()),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scavenger Hunt'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/PFT.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<Map<String, bool>>(
            future: _progress,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

              final progress = snapshot.data!;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.explore, size: 40, color: Colors.blueAccent),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Welcome to the Scavenger Hunt!\nExplore each level and find hidden locations.',
                              style: TextStyle(fontSize: 16, color: Colors.blueGrey[800]),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Explore a Level',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),

                    _buildLevelCard('1', Icons.looks_one),
                    _buildLevelCard('2', Icons.looks_two),
                    _buildLevelCard('3', Icons.looks_3),

                    const SizedBox(height: 20),

                    const Text(
                      'Other Resources',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),

                    /// ✅ This is the new "View Maps" button
                    _buildMapsButton(),

                    const SizedBox(height: 20),

                    _buildProgressSection(progress),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
