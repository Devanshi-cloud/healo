class MoodLog {
  final int? id;
  final int moodValue; // 1-5 scale
  final String note;
  final DateTime timestamp;

  MoodLog({
    this.id,
    required this.moodValue,
    required this.note,
    required this.timestamp,
  });

  /// Convert MoodLog to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'moodValue': moodValue,
      'note': note,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  /// Create MoodLog from database Map
  factory MoodLog.fromMap(Map<String, dynamic> map) {
    return MoodLog(
      id: map['id'] as int?,
      moodValue: map['moodValue'] as int,
      note: map['note'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
    );
  }

  /// Get emoji based on mood value
  String get emoji {
    switch (moodValue) {
      case 5:
        return '😊';
      case 4:
        return '😐';
      case 3:
        return '😔';
      case 2:
        return '😢';
      case 1:
        return '😤';
      default:
        return '😐';
    }
  }

  /// Get mood label based on value
  String get moodLabel {
    switch (moodValue) {
      case 5:
        return 'Happy';
      case 4:
        return 'Neutral';
      case 3:
        return 'Sad';
      case 2:
        return 'Depressed';
      case 1:
        return 'Frustrated';
      default:
        return 'Unknown';
    }
  }

  @override
  String toString() {
    return 'MoodLog(id: $id, moodValue: $moodValue, note: $note, timestamp: $timestamp)';
  }
}

