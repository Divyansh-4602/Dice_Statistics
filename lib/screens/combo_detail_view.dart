import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dice_provider.dart';

class ComboDetailView extends ConsumerWidget {
  final (int, int) combo;

  const ComboDetailView({super.key, required this.combo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diceState = ref.watch(diceProvider).current;
    final frequency = diceState.comboFrequencies[combo] ?? 0;
    final maxFrequency = ref.read(diceProvider.notifier).getMaxComboFrequency();
    final percentage = diceState.totalThrows > 0
        ? (frequency / diceState.totalThrows * 100).toStringAsFixed(2)
        : '0.00';

    return Scaffold(
      appBar: AppBar(
        title: Text('${combo.$1} & ${combo.$2}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dice Display Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDiceContainer(combo.$1, context),
                _buildDiceContainer(combo.$2, context),
              ],
            ),
            const SizedBox(height: 32),

            // Statistics Section
            _buildStatCard('Count', '$frequency', context),
            const SizedBox(height: 16),
            _buildStatCard('Total Throws', '${diceState.totalThrows}', context),
            const SizedBox(height: 16),
            _buildStatCard('Percentage', '$percentage%', context),
            const SizedBox(height: 32),

            // Frequency Visualization
            Text(
              'Relative Frequency',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: maxFrequency > 0 ? frequency / maxFrequency : 0,
              minHeight: 20,
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${(frequency / maxFrequency * 100).toStringAsFixed(1)}% of max',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 40), // Extra bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildDiceContainer(int value, BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          value.toString(),
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: 40,
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}