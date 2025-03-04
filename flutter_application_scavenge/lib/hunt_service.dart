import 'package:shared_preferences/shared_preferences.dart';

class HuntService {
  Future<Map<String, bool>> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'Level 1 - Location 1': prefs.getBool('Level 1 - Location 1') ?? false,
      'Level 1 - Location 2': prefs.getBool('Level 1 - Location 2') ?? false,
      'Level 2 - Location 1': prefs.getBool('Level 2 - Location 1') ?? false,
      'Level 2 - Location 2': prefs.getBool('Level 2 - Location 2') ?? false,
      'Level 3 - Location 1': prefs.getBool('Level 3 - Location 1') ?? false,
      'Level 3 - Location 2': prefs.getBool('Level 3 - Location 2') ?? false,
    };
  }

  Future<void> markLocationVisited(String location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(location, true);
  }
}
