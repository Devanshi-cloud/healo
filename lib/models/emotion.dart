/// Emotion model used across the check-in flow.
/// Reusable: same model for grid, search, and payload.
class Emotion {
  final String id;
  final String title;
  final String description;

  /// Category: High Energy Unpleasant | Low Energy Unpleasant |
  ///           High Energy Pleasant | Low Energy Pleasant
  final String type;

  const Emotion({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Emotion && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
