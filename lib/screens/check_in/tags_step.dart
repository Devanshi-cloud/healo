import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/check_in_flow_provider.dart';

/// Optional activity, people, place tags. Back to description, submit check-in.
/// Screen-specific: tags step.
class TagsStep extends StatefulWidget {
  final VoidCallback onSubmit;
  final bool isLoading;

  const TagsStep({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<TagsStep> createState() => _TagsStepState();
}

class _TagsStepState extends State<TagsStep> {
  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _peopleController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  bool _showActivityInput = false;
  bool _showPeopleInput = false;
  bool _showPlaceInput = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final flow = context.read<CheckInFlowProvider>().payload;
    if (flow.activityTag != null && _activityController.text.isEmpty) {
      _activityController.text = flow.activityTag!;
    }
    if (flow.peopleTag != null && _peopleController.text.isEmpty) {
      _peopleController.text = flow.peopleTag!;
    }
    if (flow.placeTag != null && _placeController.text.isEmpty) {
      _placeController.text = flow.placeTag!;
    }
  }

  @override
  void dispose() {
    _activityController.dispose();
    _peopleController.dispose();
    _placeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<CheckInFlowProvider>(
      builder: (context, flow, _) {
        return Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 24,
                left: 24,
                right: 24,
                bottom: 100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose or create tags for Check-In',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _TagSection(
                    title: 'Activity',
                    controller: _activityController,
                    showInput: _showActivityInput,
                    onToggleInput: () {
                      setState(() => _showActivityInput = !_showActivityInput);
                    },
                    onChanged: flow.setActivityTag,
                    suggestions: const [
                      'Work',
                      'Exercise',
                      'Rest',
                      'Social',
                      'Learning'
                    ],
                  ),
                  const SizedBox(height: 24),
                  _TagSection(
                    title: 'Person',
                    controller: _peopleController,
                    showInput: _showPeopleInput,
                    onToggleInput: () {
                      setState(() => _showPeopleInput = !_showPeopleInput);
                    },
                    onChanged: flow.setPeopleTag,
                    suggestions: const [
                      'Alone',
                      'Family',
                      'Friends',
                      'Colleagues'
                    ],
                  ),
                  const SizedBox(height: 24),
                  _TagSection(
                    title: 'Place',
                    controller: _placeController,
                    showInput: _showPlaceInput,
                    onToggleInput: () {
                      setState(() => _showPlaceInput = !_showPlaceInput);
                    },
                    onChanged: flow.setPlaceTag,
                    suggestions: const [
                      'Home',
                      'Office',
                      'Outdoors',
                      'Commute'
                    ],
                  ),
                ],
              ),
            ),
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
                      onTap: flow.goBackFromTags,
                      label: 'Back',
                    ),
                    FilledButton(
                      onPressed: widget.isLoading
                          ? null
                          : () {
                              flow.setActivityTag(
                                  _activityController.text.isEmpty
                                      ? null
                                      : _activityController.text);
                              flow.setPeopleTag(_peopleController.text.isEmpty
                                  ? null
                                  : _peopleController.text);
                              flow.setPlaceTag(_placeController.text.isEmpty
                                  ? null
                                  : _placeController.text);
                              widget.onSubmit();
                            },
                      child:
                          Text(widget.isLoading ? 'Checking in…' : 'Check in'),
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

class _TagSection extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool showInput;
  final VoidCallback onToggleInput;
  final ValueChanged<String?> onChanged;
  final List<String> suggestions;

  const _TagSection({
    required this.title,
    required this.controller,
    required this.showInput,
    required this.onToggleInput,
    required this.onChanged,
    required this.suggestions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...suggestions.map((tag) {
              final isSelected = controller.text == tag;
              return FilterChip(
                label: Text(tag),
                selected: isSelected,
                onSelected: (_) {
                  controller.text = tag;
                  onChanged(tag);
                },
                showCheckmark: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              );
            }),
            ActionChip(
              avatar: Icon(
                showInput ? Icons.close : Icons.add,
                size: 18,
                color: theme.colorScheme.onSurface,
              ),
              label: Text(showInput ? 'Close' : 'Add'),
              onPressed: onToggleInput,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ],
        ),
        if (showInput) ...[
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            onChanged: (v) => onChanged(v.isEmpty ? null : v),
            decoration: InputDecoration(
              hintText: 'Add new $title',
              border: const UnderlineInputBorder(),
            ),
          ),
        ],
      ],
    );
  }
}
