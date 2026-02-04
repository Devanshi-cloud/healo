import 'package:flutter/material.dart';

/// Check-in emotion quadrant colors. Matches RUOK React app for visual consistency.
/// Reusable across MorphingWaveButton, MorphingEmotion, GridChart, SearchChart.
class CheckInColors {
  CheckInColors._();

  // High Energy Unpleasant
  static const Color highEnergyUnpleasantPrimary = Color(0xFFef1a0a);
  static const Color highEnergyUnpleasantSecondary = Color(0xFF6c1d00);
  static const Color highEnergyUnpleasantAccent = Color(0xFF4d0d00);
  static const Color highEnergyUnpleasantGlow = Color(0xFFef1a0a);

  // Low Energy Unpleasant
  static const Color lowEnergyUnpleasantPrimary = Color(0xFF0b29ee);
  static const Color lowEnergyUnpleasantSecondary = Color(0xFF20006e);
  static const Color lowEnergyUnpleasantAccent = Color(0xFF340a97);
  static const Color lowEnergyUnpleasantGlow = Color(0xFF0b29ee);

  // High Energy Pleasant
  static const Color highEnergyPleasantPrimary = Color(0xFFe3b014);
  static const Color highEnergyPleasantSecondary = Color(0xFFf1c205);
  static const Color highEnergyPleasantAccent = Color(0xFFc09b09);
  static const Color highEnergyPleasantGlow = Color(0xFFe3b014);

  // Low Energy Pleasant
  static const Color lowEnergyPleasantPrimary = Color(0xFF028c5c);
  static const Color lowEnergyPleasantSecondary = Color(0xFF057a51);
  static const Color lowEnergyPleasantAccent = Color(0xFF0b885c);
  static const Color lowEnergyPleasantGlow = Color(0xFF028c5c);

  static const String highEnergyUnpleasant = 'High Energy Unpleasant';
  static const String lowEnergyUnpleasant = 'Low Energy Unpleasant';
  static const String highEnergyPleasant = 'High Energy Pleasant';
  static const String lowEnergyPleasant = 'Low Energy Pleasant';

  static Color primaryForType(String type) {
    switch (type) {
      case highEnergyUnpleasant:
        return highEnergyUnpleasantPrimary;
      case lowEnergyUnpleasant:
        return lowEnergyUnpleasantPrimary;
      case highEnergyPleasant:
        return highEnergyPleasantPrimary;
      case lowEnergyPleasant:
        return lowEnergyPleasantPrimary;
      default:
        return Colors.grey;
    }
  }

  static ({Color primary, Color secondary, Color accent, Color glow})
      paletteForType(String type) {
    switch (type) {
      case highEnergyUnpleasant:
        return (
          primary: highEnergyUnpleasantPrimary,
          secondary: highEnergyUnpleasantSecondary,
          accent: highEnergyUnpleasantAccent,
          glow: highEnergyUnpleasantGlow,
        );
      case lowEnergyUnpleasant:
        return (
          primary: lowEnergyUnpleasantPrimary,
          secondary: lowEnergyUnpleasantSecondary,
          accent: lowEnergyUnpleasantAccent,
          glow: lowEnergyUnpleasantGlow,
        );
      case highEnergyPleasant:
        return (
          primary: highEnergyPleasantPrimary,
          secondary: highEnergyPleasantSecondary,
          accent: highEnergyPleasantAccent,
          glow: highEnergyPleasantGlow,
        );
      case lowEnergyPleasant:
        return (
          primary: lowEnergyPleasantPrimary,
          secondary: lowEnergyPleasantSecondary,
          accent: lowEnergyPleasantAccent,
          glow: lowEnergyPleasantGlow,
        );
      default:
        return (
          primary: Colors.grey,
          secondary: Colors.grey.shade400,
          accent: Colors.grey.shade300,
          glow: Colors.grey.shade200,
        );
    }
  }

  /// Mood category config for the 2x2 main step buttons.
  static List<MoodCategoryConfig> get moodCategories => [
        MoodCategoryConfig(
          label: highEnergyUnpleasant,
          primary: highEnergyUnpleasantPrimary,
          secondary: highEnergyUnpleasantSecondary,
          accent: highEnergyUnpleasantAccent,
          glow: highEnergyUnpleasantGlow,
        ),
        MoodCategoryConfig(
          label: lowEnergyUnpleasant,
          primary: lowEnergyUnpleasantPrimary,
          secondary: lowEnergyUnpleasantSecondary,
          accent: lowEnergyUnpleasantAccent,
          glow: lowEnergyUnpleasantGlow,
        ),
        MoodCategoryConfig(
          label: highEnergyPleasant,
          primary: highEnergyPleasantPrimary,
          secondary: highEnergyPleasantSecondary,
          accent: highEnergyPleasantAccent,
          glow: highEnergyPleasantGlow,
        ),
        MoodCategoryConfig(
          label: lowEnergyPleasant,
          primary: lowEnergyPleasantPrimary,
          secondary: lowEnergyPleasantSecondary,
          accent: lowEnergyPleasantAccent,
          glow: lowEnergyPleasantGlow,
        ),
      ];
}

class MoodCategoryConfig {
  final String label;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color glow;

  const MoodCategoryConfig({
    required this.label,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.glow,
  });
}
