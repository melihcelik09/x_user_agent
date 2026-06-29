import 'package:flutter/material.dart';
import 'package:x_user_agent/x_user_agent.dart';

class SummaryRow extends StatelessWidget {
  const SummaryRow({
    required this.userAgentData,
    super.key,
  });

  final XUserAgentData userAgentData;

  @override
  Widget build(BuildContext context) {
    final entries = <({String label, String value})>[
      (label: 'Platform', value: userAgentData.platform ?? 'Unknown'),
      (label: 'Version', value: userAgentData.platformVersion ?? 'Unknown'),
      (
        label: 'Device',
        value: userAgentData.model ?? userAgentData.device ?? 'Unknown',
      ),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: entries
          .map(
            (entry) => SummaryChip(
              label: entry.label,
              value: entry.value,
            ),
          )
          .toList(),
    );
  }
}

class SummaryChip extends StatelessWidget {
  const SummaryChip({
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

    return Container(
      constraints: const BoxConstraints(minWidth: 160),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: colorScheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
