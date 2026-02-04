import 'package:flutter/foundation.dart';
import '../models/mood_log.dart';
import '../services/database_helper.dart';

class MoodProvider with ChangeNotifier {
  List<MoodLog> _moodLogs = [];
  List<MoodLog> _weeklyMoodLogs = [];
  MoodLog? _todaysMoodLog;
  bool _isLoading = false;
  int? _selectedMood;
  String _noteText = '';

  // Getters
  List<MoodLog> get moodLogs => _moodLogs;
  List<MoodLog> get weeklyMoodLogs => _weeklyMoodLogs;
  MoodLog? get todaysMoodLog => _todaysMoodLog;
  bool get isLoading => _isLoading;
  int? get selectedMood => _selectedMood;
  String get noteText => _noteText;

  // Check if user has logged today
  bool get hasLoggedToday => _todaysMoodLog != null;

  /// Initialize and load data
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    await Future.wait([
      loadAllMoodLogs(),
      loadWeeklyMoodLogs(),
      checkTodaysMoodLog(),
    ]);

    _isLoading = false;
    notifyListeners();
  }

  /// Load all mood logs from database
  Future<void> loadAllMoodLogs() async {
    _moodLogs = await DatabaseHelper.instance.getAllMoodLogs();
    notifyListeners();
  }

  /// Load last 7 mood logs for the chart
  Future<void> loadWeeklyMoodLogs() async {
    _weeklyMoodLogs = await DatabaseHelper.instance.getLastNMoodLogs(7);
    notifyListeners();
  }

  /// Check if user has logged mood today
  Future<void> checkTodaysMoodLog() async {
    _todaysMoodLog = await DatabaseHelper.instance.getTodaysMoodLog();
    notifyListeners();
  }

  /// Set selected mood (1-5)
  void setSelectedMood(int? mood) {
    _selectedMood = mood;
    notifyListeners();
  }

  /// Set note text
  void setNoteText(String text) {
    _noteText = text;
    notifyListeners();
  }

  /// Save mood log to database
  Future<bool> saveMoodLog() async {
    if (_selectedMood == null) return false;

    try {
      final moodLog = MoodLog(
        moodValue: _selectedMood!,
        note: _noteText,
        timestamp: DateTime.now(),
      );

      await DatabaseHelper.instance.insertMoodLog(moodLog);

      // Reset input state
      _selectedMood = null;
      _noteText = '';

      // Reload data
      await initialize();

      return true;
    } catch (e) {
      debugPrint('Error saving mood log: $e');
      return false;
    }
  }

  /// Delete a mood log
  Future<void> deleteMoodLog(int id) async {
    await DatabaseHelper.instance.deleteMoodLog(id);
    await initialize();
  }

  /// Get average mood for the week
  double get weeklyAverageMood {
    if (_weeklyMoodLogs.isEmpty) return 0;
    final sum = _weeklyMoodLogs.fold<int>(
      0,
      (sum, log) => sum + log.moodValue,
    );
    return sum / _weeklyMoodLogs.length;
  }

  /// Get mood distribution for statistics
  Map<int, int> get moodDistribution {
    final distribution = <int, int>{1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (final log in _moodLogs) {
      distribution[log.moodValue] = (distribution[log.moodValue] ?? 0) + 1;
    }
    return distribution;
  }

  /// Clear selection state (for form reset)
  void clearSelection() {
    _selectedMood = null;
    _noteText = '';
    notifyListeners();
  }
}

