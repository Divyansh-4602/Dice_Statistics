import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../routing/app_router.dart';
import '../routing/route_names.dart';

class FrequencyGrid extends ConsumerWidget {
  final Map<(int, int), int> comboFrequencies;
  final int maxFrequency;

  const FrequencyGrid({
    super.key,
    required this.comboFrequencies,
    required this.maxFrequency,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        childAspectRatio: 1,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: 36,
      itemBuilder: (context, index) {
        final die1 = (index ~/ 6) + 1;
        final die2 = (index % 6) + 1;
        final combo = (die1, die2);
        final frequency = comboFrequencies[combo] ?? 0;
        final ratio = maxFrequency > 0 ? frequency / maxFrequency : 0.0;

        return GestureDetector(
          onTap: () {
            ref.read(appRouterProvider).push(
              RouteNames.comboDetailView,
              extra: combo,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color.lerp(
                Colors.red,
                Colors.green,
                ratio,
              ),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 0.5,
              ),
            ),
            child: Center(
              child: Text(
                '$frequency',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ratio > 0.5 ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}