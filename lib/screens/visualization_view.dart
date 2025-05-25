import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dice_provider.dart';
import '../widgets/sum_bar_chart.dart';
import '../widgets/frequency_grid.dart';

class VisualizationView extends ConsumerWidget {
  const VisualizationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diceState = ref.watch(diceProvider).current;
    final diceNotifier = ref.read(diceProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sum Frequencies Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Sum Frequencies',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 300,
                child: SumBarChart(
                  sumFrequencies: diceState.sumFrequencies,
                  maxFrequency: diceNotifier.getMaxSumFrequency(),
                ),
              ),
              const SizedBox(height: 24),

              // Divider
              const Divider(thickness: 1),
              const SizedBox(height: 24),

              // Combination Frequencies Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Combination Frequencies',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: FrequencyGrid(
                  comboFrequencies: diceState.comboFrequencies,
                  maxFrequency: diceNotifier.getMaxComboFrequency(),
                ),
              ),
              // Add extra space at bottom to account for nav bar
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}