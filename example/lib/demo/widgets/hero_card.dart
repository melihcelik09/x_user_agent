import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({
    required this.isLoading,
    required this.hasData,
    required this.onPressed,
    super.key,
  });

  final bool isLoading;
  final bool hasData;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'x_user_agent demo',
              style: theme.textTheme.labelLarge?.copyWith(
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Inspect mobile user-agent data in one place.',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Load the current device values for WebView, native networking, '
            'structured user-agent fields, and client hints headers.',
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: onPressed,
            icon: isLoading
                ? SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: colorScheme.onPrimary,
                    ),
                  )
                : Icon(
                    hasData ? Icons.refresh_rounded : Icons.play_arrow_rounded,
                  ),
            label: Text(
              isLoading
                  ? 'Loading…'
                  : hasData
                  ? 'Reload inspector'
                  : 'Load inspector',
            ),
          ),
        ],
      ),
    );
  }
}
