import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/mood_log.dart';

// Platform-agnostic storage that works on Web, iOS, Android, macOS, etc.
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static const String _moodLogsKey = 'mood_logs';
  static int _idCounter = 0;

  DatabaseHelper._init();

  /// Get all mood logs from storage
  Future<List<MoodLog>> getAllMoodLogs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonString = prefs.getString(_moodLogsKey);
      
      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final List<dynamic> jsonList = json.decode(jsonString);
      final logs = jsonList.map((item) => MoodLog.fromMap(item)).toList();
      
      // Update id counter
      if (logs.isNotEmpty) {
        _idCounter = logs.map((l) => l.id ?? 0).reduce((a, b) => a > b ? a : b);
      }
      
      // Sort by timestamp descending
      logs.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return logs;
    } catch (e) {
      debugPrint('Error loading mood logs: $e');
      return [];
    }
  }

  /// Insert a new mood log
  Future<int> insertMoodLog(MoodLog moodLog) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final logs = await getAllMoodLogs();
      
      _idCounter++;
      final newLog = MoodLog(
        id: _idCounter,
        moodValue: moodLog.moodValue,
        note: moodLog.note,
        timestamp: moodLog.timestamp,
      );
      
      logs.insert(0, newLog);
      
      final jsonList = logs.map((log) => log.toMap()).toList();
      await prefs.setString(_moodLogsKey, json.encode(jsonList));
      
      return _idCounter;
    } catch (e) {
      debugPrint('Error inserting mood log: $e');
      return -1;
    }
  }

  /// Get the last N mood logs for charting
  Future<List<MoodLog>> getLastNMoodLogs(int n) async {
    final logs = await getAllMoodLogs();
    
    // Sort by timestamp ascending for chart display
    logs.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    
    if (logs.length <= n) {
      return logs;
    }
    
    return logs.sublist(logs.length - n);
  }

  /// Get mood logs for the last 7 days
  Future<List<MoodLog>> getMoodLogsLast7Days() async {
    final logs = await getAllMoodLogs();
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    
    final filtered = logs.where((log) => log.timestamp.isAfter(sevenDaysAgo)).toList();
    filtered.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    
    return filtered;
  }

  /// Delete a mood log by ID
  Future<int> deleteMoodLog(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final logs = await getAllMoodLogs();
      
      logs.removeWhere((log) => log.id == id);
      
      final jsonList = logs.map((log) => log.toMap()).toList();
      await prefs.setString(_moodLogsKey, json.encode(jsonList));
      
      return 1;
    } catch (e) {
      debugPrint('Error deleting mood log: $e');
      return 0;
    }
  }

  /// Update a mood log
  Future<int> updateMoodLog(MoodLog moodLog) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final logs = await getAllMoodLogs();
      
      final index = logs.indexWhere((log) => log.id == moodLog.id);
      if (index != -1) {
        logs[index] = moodLog;
      }
      
      final jsonList = logs.map((log) => log.toMap()).toList();
      await prefs.setString(_moodLogsKey, json.encode(jsonList));
      
      return 1;
    } catch (e) {
      debugPrint('Error updating mood log: $e');
      return 0;
    }
  }

  /// Get today's mood log if exists
  Future<MoodLog?> getTodaysMoodLog() async {
    final logs = await getAllMoodLogs();
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    try {
      return logs.firstWhere(
        (log) => log.timestamp.isAfter(startOfDay) && log.timestamp.isBefore(endOfDay),
      );
    } catch (e) {
      return null;
    }
  }

  /// Close the database (no-op for SharedPreferences)
  Future<void> close() async {
    // No-op for SharedPreferences
  }
}
