import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/check_in_flow_provider.dart';
import '../../widgets/check_in/description_gradient_background.dart';

/// Description input with animated gradient background. Back to chart, next to tags.
/// Screen-specific: description step.
class DescriptionStep extends StatefulWidget {
  const DescriptionStep({super.key});

  @override
  State<DescriptionStep> createState() => _DescriptionStepState();
}

class _DescriptionStepState extends State<DescriptionStep> {
  final TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final desc = context.read<CheckInFlowProvider>().payload.description;
    if (desc != null && _controller.text != desc) {
      _controller.text = desc;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Consumer<CheckInFlowProvider>(
      builder: (context, flow, _) {
        return Stack(
          children: [
            DescriptionGradientBackground(
              isDark: isDark,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Describe the cause',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      TextField(
                        controller: _controller,
                        onChanged: flow.setDescription,
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: 'Write your thoughts here...',
                          filled: true,
                          fillColor: isDark
                              ? Colors.white.withOpacity(0.08)
                              : Colors.black.withOpacity(0.04),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Bottom nav
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _RoundButton(
                      icon: Icons.chevron_left,
                      onTap: flow.goBackFromDescription,
                      label: 'Back',
                    ),
                    _RoundButton(
                      icon: Icons.chevron_right,
                      onTap: flow.goToTags,
                      label: 'Next',
                    ),
                  ],
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
