import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../routing/route_names.dart';
import '../routing/app_router.dart';
import '../providers/dice_provider.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final location = router.routeInformationProvider.value.uri.path;
    final canUndo = ref.watch(diceProvider.select((state) => state.history.isNotEmpty));

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Left-aligned icons
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.casino),
                  onPressed: () => router.go(RouteNames.diceView),
                  color: location == RouteNames.diceView
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).iconTheme.color,
                ),
                IconButton(
                  icon: const Icon(Icons.bar_chart),
                  onPressed: () => router.go(RouteNames.visualizationView),
                  color: location == RouteNames.visualizationView
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).iconTheme.color,
                ),
              ],
            ),
          ),

          // Right-aligned icons
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => router.go(RouteNames.settingsView),
                  color: location == RouteNames.settingsView
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).iconTheme.color,
                ),
                IconButton(
                  icon: const Icon(Icons.undo),
                  onPressed: canUndo
                      ? () => ref.read(diceProvider.notifier).undo()
                      : null,
                  color: canUndo
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).disabledColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}