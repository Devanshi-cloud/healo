import 'package:flutter/material.dart';
import '../../models/emotion.dart';
import '../../theme/check_in_colors.dart';

/// Bottom preview card showing selected emotion with "next" to description.
/// Screen-specific: used in grid chart step.
class EmotionPreviewCard extends StatelessWidget {
  final Emotion emotion;
  final VoidCallback onNext;

  const EmotionPreviewCard({
    super.key,
    required this.emotion,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final primary = CheckInColors.primaryForType(emotion.type);
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.95),
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: primary.withOpacity(0.12),
              blurRadius: 16,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    emotion.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    emotion.description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Material(
              color: theme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black87,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onNext,
                customBorder: const CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Icon(
                    Icons.chevron_right,
                    color: theme.brightness == Brightness.dark
                        ? Colors.black87
                        : Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
