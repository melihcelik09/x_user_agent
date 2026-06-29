import 'package:flutter/material.dart';

class KeyValueList extends StatelessWidget {
  const KeyValueList({
    required this.entries,
    super.key,
  });

  final Map<String, Object?> entries;

  @override
  Widget build(BuildContext context) {
    final visibleEntries = entries.entries
        .where((entry) => entry.value != null && '${entry.value}'.isNotEmpty)
        .toList();

    return Column(
      children: visibleEntries
          .map(
            (entry) => KeyValueRow(
              label: entry.key,
              value: '${entry.value}',
            ),
          )
          .toList(),
    );
  }
}

class KeyValueRow extends StatelessWidget {
  const KeyValueRow({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 6),
            SelectableText(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
