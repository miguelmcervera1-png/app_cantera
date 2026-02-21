import 'package:flutter/material.dart';
import 'package:app_cantera/l10n/generated/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_theme.dart';
import '../../data/models/match_model.dart';

class MatchCard extends StatelessWidget {
  final MatchModel match;

  const MatchCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat('EEEE d MMM, HH:mm', l10n.localeName);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.sports_soccer, color: AppTheme.primaryBlue),
                const SizedBox(width: 8),
                Text(
                  l10n.nextMatch,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryBlue,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Center(
              child: Text(
                'La 21 ${l10n.vs} ${match.rival}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _InfoRow(
              icon: Icons.calendar_today,
              text: dateFormat.format(match.date),
            ),
            const SizedBox(height: 8),
            _InfoRow(icon: Icons.location_on, text: match.location),
            const SizedBox(height: 8),
            _InfoRow(
              icon: Icons.group,
              text: '${l10n.category}: ${match.category}',
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}
