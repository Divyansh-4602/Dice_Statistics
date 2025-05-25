import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dice_provider.dart';

class SumDetailView extends ConsumerWidget {
  final int sum;

  const SumDetailView({super.key, required this.sum});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diceState = ref.watch(diceProvider).current;
    final frequency = diceState.sumFrequencies[sum] ?? 0;
    final maxFrequency = ref.read(diceProvider.notifier).getMaxSumFrequency();
    final percentage = diceState.totalThrows > 0
        ? (frequency / diceState.totalThrows * 100).toStringAsFixed(2)
        : '0.00';

    return Scaffold(
      appBar: AppBar(
        title: Text('Sum of $sum'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sum: $sum',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 32),
            Text(
              'Count: $frequency',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Total Throws: ${diceState.totalThrows}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Percentage: $percentage%',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 32),
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
              'Relative frequency: ${(frequency / maxFrequency * 100).toStringAsFixed(1)}% of max',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}