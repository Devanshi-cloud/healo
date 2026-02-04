import 'package:flutter/foundation.dart';
import '../services/preferences_service.dart';

class SettingsProvider with ChangeNotifier {
  bool _dailyReminderEnabled = false;
  bool _isLoading = true;

  bool get dailyReminderEnabled => _dailyReminderEnabled;
  bool get isLoading => _isLoading;

  /// Initialize settings from preferences
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    _dailyReminderEnabled = await PreferencesService.getDailyReminderEnabled();

    _isLoading = false;
    notifyListeners();
  }

  /// Toggle daily reminder setting
  Future<void> toggleDailyReminder(bool enabled) async {
    _dailyReminderEnabled = enabled;
    notifyListeners();

    await PreferencesService.setDailyReminderEnabled(enabled);

    // Mock functionality - in a real app, this would schedule/cancel notifications
    if (enabled) {
      debugPrint('Daily reminder enabled - notifications would be scheduled here');
    } else {
      debugPrint('Daily reminder disabled - notifications would be cancelled here');
    }
  }
}

