import 'package:flutter/material.dart';

class MoodEmojiSelector extends StatelessWidget {
  final int? selectedMood;
  final Function(int) onMoodSelected;

  const MoodEmojiSelector({
    super.key,
    required this.selectedMood,
    required this.onMoodSelected,
  });

  static const List<Map<String, dynamic>> moods = [
    {'value': 5, 'emoji': '😊', 'label': 'Happy', 'color': Color(0xFF4CAF50)},
    {'value': 4, 'emoji': '😐', 'label': 'Neutral', 'color': Color(0xFF8BC34A)},
    {'value': 3, 'emoji': '😔', 'label': 'Sad', 'color': Color(0xFFFFC107)},
    {
      'value': 2,
      'emoji': '😢',
      'label': 'Depressed',
      'color': Color(0xFFFF9800)
    },
    {
      'value': 1,
      'emoji': '😤',
      'label': 'Frustrated',
      'color': Color(0xFFE57373)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: moods.map((mood) {
            final isSelected = selectedMood == mood['value'];
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _MoodButton(
                  emoji: mood['emoji'] as String,
                  label: mood['label'] as String,
                  isSelected: isSelected,
                  accentColor: mood['color'] as Color,
                  onTap: () => onMoodSelected(mood['value'] as int),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        AnimatedOpacity(
          opacity: selectedMood != null ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: selectedMood != null
              ? Text(
                  'Feeling ${moods.firstWhere((m) => m['value'] == selectedMood)['label']}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _MoodButton extends StatefulWidget {
  final String emoji;
  final String label;
  final bool isSelected;
  final Color accentColor;
  final VoidCallback onTap;

  const _MoodButton({
    required this.emoji,
    required this.label,
    required this.isSelected,
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<_MoodButton> createState() => _MoodButtonState();
}

class _MoodButtonState extends State<_MoodButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? widget.accentColor.withOpacity(0.2)
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:
                  widget.isSelected ? widget.accentColor : Colors.transparent,
              width: 2,
            ),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: widget.accentColor.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedScale(
                  scale: widget.isSelected ? 1.2 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    widget.emoji,
                    style: const TextStyle(fontSize: 36),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight:
                        widget.isSelected ? FontWeight.bold : FontWeight.normal,
                    color: widget.isSelected
                        ? widget.accentColor
                        : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedBuilder extends StatelessWidget {
  final Animation<double> animation;
  final Widget Function(BuildContext, Widget?) builder;
  final Widget? child;

  const AnimatedBuilder({
    super.key,
    required this.animation,
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder2(
      animation: animation,
      builder: builder,
      child: child,
    );
  }
}

class AnimatedBuilder2 extends AnimatedWidget {
  final Widget Function(BuildContext, Widget?) builder;
  final Widget? child;

  const AnimatedBuilder2({
    super.key,
    required Animation<double> animation,
    required this.builder,
    this.child,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }
}
