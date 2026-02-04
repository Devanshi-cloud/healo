import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/check_in_flow_provider.dart';
import '../../theme/check_in_colors.dart';

/// Search + list of emotions. Toggle back to grid from here.
/// Screen-specific: chart step in search mode.
class SearchChartStep extends StatefulWidget {
  const SearchChartStep({super.key});

  @override
  State<SearchChartStep> createState() => _SearchChartStepState();
}

class _SearchChartStepState extends State<SearchChartStep> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final flow = context.read<CheckInFlowProvider>();
    if (_searchController.text != flow.searchQuery) {
      _searchController.text = flow.searchQuery;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<CheckInFlowProvider>(
      builder: (context, flow, _) {
        final filtered = flow.displayedEmotions;
        final selected = flow.selectedEmotion;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top bar: grid toggle, clear selection
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 8,
                left: 16,
                right: 16,
                bottom: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (selected != null)
                    _RoundButton(
                      icon: Icons.close,
                      onTap: () => flow.selectEmotion(null),
                      label: 'Clear',
                    ),
                  const SizedBox(width: 8),
                  _RoundButton(
                    icon: Icons.grid_view,
                    onTap: () => flow.setSearchMode(false),
                    label: 'Grid view',
                  ),
                ],
              ),
            ),
            // Title + search field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Which emotion matches how you feel the best?',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _searchController,
                    onChanged: flow.setSearchQuery,
                    decoration: InputDecoration(
                      hintText: 'Search for relevant emotion',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Scrollable list
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        'No emotions found for this search.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final emotion = filtered[index];
                        final isSelected = selected?.id == emotion.id;
                        final primary =
                            CheckInColors.primaryForType(emotion.type);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Material(
                            color: isSelected
                                ? primary
                                : theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(999),
                            child: InkWell(
                              onTap: () => flow.selectEmotion(emotion),
                              borderRadius: BorderRadius.circular(999),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            emotion.title,
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                              color: isSelected
                                                  ? Colors.white
                                                  : theme.colorScheme.onSurface,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            emotion.description,
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                              color: isSelected
                                                  ? Colors.white70
                                                  : theme.colorScheme
                                                      .onSurfaceVariant,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            // Bottom nav: back, next
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _RoundButton(
                      icon: Icons.chevron_left,
                      onTap: flow.goBackFromChart,
                      label: 'Back to mood',
                    ),
                    _RoundButton(
                      icon: Icons.chevron_right,
                      onTap: flow.goToDescription,
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
