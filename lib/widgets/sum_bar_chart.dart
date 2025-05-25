import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../routing/app_router.dart';
import '../routing/route_names.dart';

class SumBarChart extends ConsumerWidget {
  final Map<int, int> sumFrequencies;
  final int maxFrequency;

  const SumBarChart({
    super.key,
    required this.sumFrequencies,
    required this.maxFrequency,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Calculate total width needed (11 bars * 40 width + 10 gaps * 8)
    const barWidth = 40.0;
    const barSpacing = 8.0;
    final totalWidth = 11 * barWidth + 10 * barSpacing;

    return Column(
      children: [
        SizedBox(
          height: 300,
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: totalWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(11, (index) {
                    final sum = index + 2;
                    final frequency = sumFrequencies[sum] ?? 0;
                    final ratio = maxFrequency > 0 ? frequency / maxFrequency : 0.0;

                    return GestureDetector(
                      onTap: () {
                        ref.read(appRouterProvider).push(
                          RouteNames.sumDetailView,
                          extra: sum,
                        );
                      },
                      child: Container(
                        width: barWidth,
                        margin: EdgeInsets.only(
                          right: index == 10 ? 0 : barSpacing,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '$frequency',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 250 * ratio,
                              decoration: BoxDecoration(
                                color: Color.lerp(
                                  Colors.red,
                                  Colors.green,
                                  ratio,
                                ),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(4),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$sum',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}