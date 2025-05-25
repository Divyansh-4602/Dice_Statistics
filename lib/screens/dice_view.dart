import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/dice_widget.dart';
import '../providers/dice_provider.dart';

class DiceView extends ConsumerWidget {
  const DiceView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diceState = ref.watch(diceProvider).current;
    final diceNotifier = ref.read(diceProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 600,
                minHeight: 600,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Tappable Dice Area
                    GestureDetector(
                      onTap: () => diceNotifier.throwDice(),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DiceWidget(value: diceState.lastThrow.$1),
                            DiceWidget(value: diceState.lastThrow.$2),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Statistics Section
                    Text(
                      'Total throws: ${diceState.totalThrows}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Mode: ${diceState.equalDistribution ? "Equal" : "Normal"}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 40),

                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => diceNotifier.throwDice(),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(120, 50),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          child: const Text('Throw'),
                        ),
                        ElevatedButton(
                          onPressed: () => diceNotifier.throwDiceMultipleTimes(1000),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(120, 50),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          child: const Text('1000 Throws'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}