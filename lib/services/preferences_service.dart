import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _dailyReminderKey = 'daily_reminder_enabled';

  static Future<bool> getDailyReminderEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_dailyReminderKey) ?? false;
  }

  static Future<void> setDailyReminderEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_dailyReminderKey, enabled);
  }
}

