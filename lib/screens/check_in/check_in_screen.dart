import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/check_in_flow_provider.dart';
import '../../providers/mood_provider.dart';
import '../../theme/check_in_colors.dart';
import '../../widgets/check_in/morphing_wave_button.dart';
import 'description_step.dart';
import 'grid_chart_step.dart';
import 'search_chart_step.dart';
import 'tags_step.dart';

/// Full check-in flow: main → chart (grid/search) → description → tags → submit.
/// Single source of truth for step is [CheckInFlowProvider].
class CheckInScreen extends StatefulWidget {
  final VoidCallback? onComplete;

  const CheckInScreen({super.key, this.onComplete});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  bool _isSubmitting = false;

  Future<void> _submitCheckIn(BuildContext context) async {
    final flow = context.read<CheckInFlowProvider>();
    final mood = context.read<MoodProvider>();
    final payload = flow.payload;
    if (payload.emotionTitle == null || payload.emotionTitle!.isEmpty) return;

    setState(() => _isSubmitting = true);

    // Map emotion category to 1–5 scale for existing MoodLog model
    final moodValue = _moodValueFromCategory(flow.selectedCategory);
    mood.setNoteText(payload.buildNote());
    mood.setSelectedMood(moodValue);
    final success = await mood.saveMoodLog();

    if (context.mounted) {
      setState(() => _isSubmitting = false);
      if (success) {
        flow.completeFlow();
        widget.onComplete?.call();
        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Check-in saved.'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        }
      }
      mood.clearSelection();
    }
  }

  int _moodValueFromCategory(String? category) {
    if (category == null) return 3;
    switch (category) {
      case CheckInColors.highEnergyUnpleasant:
        return 1;
      case CheckInColors.lowEnergyUnpleasant:
        return 2;
      case CheckInColors.highEnergyPleasant:
        return 5;
      case CheckInColors.lowEnergyPleasant:
        return 4;
      default:
        return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CheckInFlowProvider>(
        builder: (context, flow, _) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: _buildStep(context, flow),
          );
        },
      ),
    );
  }

  Widget _buildStep(BuildContext context, CheckInFlowProvider flow) {
    switch (flow.step) {
      case CheckInStep.main:
        return _MainStep(key: const ValueKey('main'));
      case CheckInStep.chart:
        return flow.isSearchMode
            ? SearchChartStep(key: const ValueKey('search'))
            : GridChartStep(key: const ValueKey('grid'));
      case CheckInStep.description:
        return const DescriptionStep(key: ValueKey('description'));
      case CheckInStep.tags:
        return TagsStep(
          key: const ValueKey('tags'),
          onSubmit: () => _submitCheckIn(context),
          isLoading: _isSubmitting,
        );
    }
  }
}

class _MainStep extends StatelessWidget {
  const _MainStep({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<CheckInFlowProvider>(
      builder: (context, flow, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'How do you feel right now?',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: CheckInColors.moodCategories.map((cat) {
                    return MorphingWaveButton(
                      text: cat.label,
                      primary: cat.primary,
                      secondary: cat.secondary,
                      accent: cat.accent,
                      glow: cat.glow,
                      onTap: () => flow.selectCategory(cat.label),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
