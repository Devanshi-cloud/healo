import 'package:flutter/foundation.dart';

import '../data/emotions_data.dart';
import '../models/emotion.dart';

/// Steps in the check-in flow. Order must match UX: main → chart → description → tags.
enum CheckInStep { main, chart, description, tags }

/// Payload built during check-in; maps to MoodLog on submit (emotion title + description as note).
class CheckInPayload {
  final String? emotionTitle;
  final String? description;
  final String? activityTag;
  final String? placeTag;
  final String? peopleTag;

  const CheckInPayload({
    this.emotionTitle,
    this.description,
    this.activityTag,
    this.placeTag,
    this.peopleTag,
  });

  CheckInPayload copyWith({
    String? emotionTitle,
    String? description,
    String? activityTag,
    String? placeTag,
    String? peopleTag,
  }) {
    return CheckInPayload(
      emotionTitle: emotionTitle ?? this.emotionTitle,
      description: description ?? this.description,
      activityTag: activityTag ?? this.activityTag,
      placeTag: placeTag ?? this.placeTag,
      peopleTag: peopleTag ?? this.peopleTag,
    );
  }

  /// Build note string for MoodLog: "Emotion: {title}. {description}. Tags: ..."
  String buildNote() {
    final parts = <String>[];
    if (emotionTitle != null && emotionTitle!.isNotEmpty) {
      parts.add('Emotion: $emotionTitle');
    }
    if (description != null && description!.isNotEmpty) {
      parts.add(description!);
    }
    final tagParts = <String>[];
    if (activityTag != null && activityTag!.isNotEmpty)
      tagParts.add(activityTag!);
    if (placeTag != null && placeTag!.isNotEmpty) tagParts.add(placeTag!);
    if (peopleTag != null && peopleTag!.isNotEmpty) tagParts.add(peopleTag!);
    if (tagParts.isNotEmpty) {
      parts.add('Tags: ${tagParts.join(', ')}');
    }
    return parts.isEmpty ? '' : parts.join('. ');
  }
}

/// Single source of truth for the check-in emotion flow state.
/// Screen-specific: used only by the check-in flow screens.
class CheckInFlowProvider with ChangeNotifier {
  CheckInStep _step = CheckInStep.main;
  String? _selectedCategory;
  List<Emotion> _filteredEmotions = [];
  Emotion? _selectedEmotion;
  bool _isSearchMode = false;
  String _searchQuery = '';
  CheckInPayload _payload = const CheckInPayload();

  CheckInStep get step => _step;
  String? get selectedCategory => _selectedCategory;
  List<Emotion> get filteredEmotions => _filteredEmotions;
  Emotion? get selectedEmotion => _selectedEmotion;
  bool get isSearchMode => _isSearchMode;
  String get searchQuery => _searchQuery;
  CheckInPayload get payload => _payload;

  List<Emotion> get allEmotions => getAllEmotions();

  /// Emotions for current category, filtered by search when in search mode.
  List<Emotion> get displayedEmotions {
    if (_filteredEmotions.isEmpty) return [];
    if (!_isSearchMode) return _filteredEmotions;
    if (_searchQuery.trim().isEmpty) return _filteredEmotions;
    final q = _searchQuery.toLowerCase();
    return _filteredEmotions
        .where((e) =>
            e.title.toLowerCase().contains(q) ||
            e.description.toLowerCase().contains(q))
        .toList();
  }

  void goToMain() {
    _step = CheckInStep.main;
    _selectedCategory = null;
    _filteredEmotions = [];
    _selectedEmotion = null;
    _searchQuery = '';
    _payload = const CheckInPayload();
    _isSearchMode = false;
    notifyListeners();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    _filteredEmotions = getEmotionsByType(category);
    _selectedEmotion = null;
    _searchQuery = '';
    _step = CheckInStep.chart;
    _payload = _payload.copyWith(emotionTitle: null);
    notifyListeners();
  }

  void setSearchMode(bool value) {
    _isSearchMode = value;
    if (!value) _searchQuery = '';
    notifyListeners();
  }

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void selectEmotion(Emotion? emotion) {
    _selectedEmotion = emotion;
    _payload = _payload.copyWith(emotionTitle: emotion?.title);
    notifyListeners();
  }

  void goBackFromChart() {
    goToMain();
  }

  void goToDescription() {
    if (_selectedEmotion == null) return;
    _step = CheckInStep.description;
    notifyListeners();
  }

  void setDescription(String? value) {
    _payload = _payload.copyWith(description: value);
    notifyListeners();
  }

  void goBackFromDescription() {
    _step = CheckInStep.chart;
    notifyListeners();
  }

  void goToTags() {
    _step = CheckInStep.tags;
    notifyListeners();
  }

  void setActivityTag(String? value) {
    _payload = _payload.copyWith(activityTag: value);
    notifyListeners();
  }

  void setPlaceTag(String? value) {
    _payload = _payload.copyWith(placeTag: value);
    notifyListeners();
  }

  void setPeopleTag(String? value) {
    _payload = _payload.copyWith(peopleTag: value);
    notifyListeners();
  }

  void goBackFromTags() {
    _step = CheckInStep.description;
    notifyListeners();
  }

  /// Call after successful submit to reset flow.
  void completeFlow() {
    goToMain();
  }
}
