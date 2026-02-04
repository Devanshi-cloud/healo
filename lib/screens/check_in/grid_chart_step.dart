import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/check_in_flow_provider.dart';
import '../../widgets/check_in/emotion_preview_card.dart';
import '../../widgets/check_in/morphing_emotion.dart';

/// Draggable grid of morphing emotion bubbles + preview card at bottom.
/// Screen-specific: chart step in grid mode.
class GridChartStep extends StatelessWidget {
  const GridChartStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckInFlowProvider>(
      builder: (context, flow, _) {
        final emotionsList = flow.displayedEmotions;
        final selected = flow.selectedEmotion;

        return Stack(
          children: [
            // Draggable/pannable grid (InteractiveViewer for pan + zoom feel)
            Positioned.fill(
              child: InteractiveViewer(
                minScale: 0.7,
                maxScale: 1.5,
                boundaryMargin: const EdgeInsets.all(800),
                child: Padding(
                  padding: const EdgeInsets.only(top: 100, bottom: 160),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 12,
                    children: emotionsList.map((emotion) {
                      return MorphingEmotion(
                        key: ValueKey(emotion.id),
                        emotion: emotion,
                        onTap: () => flow.selectEmotion(emotion),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            // Top bar: back, clear selection, search
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _RoundButton(
                    icon: Icons.chevron_left,
                    onTap: flow.goBackFromChart,
                    label: 'Back to mood',
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (selected != null)
                        _RoundButton(
                          icon: Icons.close,
                          onTap: () => flow.selectEmotion(null),
                          label: 'Clear',
                        ),
                      const SizedBox(width: 8),
                      _RoundButton(
                        icon: Icons.search,
                        onTap: () => flow.setSearchMode(true),
                        label: 'Search',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Bottom preview card when emotion selected
            if (selected != null)
              Positioned(
                left: 24,
                right: 24,
                bottom: 24,
                child: SafeArea(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: EmotionPreviewCard(
                      key: ValueKey(selected.id),
                      emotion: selected,
                      onNext: flow.goToDescription,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String label;

  const _RoundButton({
    required this.icon,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: Colors.black.withOpacity(0.35),
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }
}
