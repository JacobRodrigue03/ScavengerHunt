import 'package:shared_preferences/shared_preferences.dart';

class HuntService {
  static const List<String> allLocations = [
    '1st Story - Panera',
    '1st Story - Auditorium',
    '2nd Story - Student Gathering Space',
    '2nd Story - Robots',
    '3rd Story - School of EE and CS',
    '3rd Story - Bayport Technical Center',
  ];

  Future<Map<String, bool>> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      for (final location in allLocations)
        location: prefs.getBool(location) ?? false,
    };
  }

  Future<void> markLocationVisited(String location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(location, true);
  }
}
