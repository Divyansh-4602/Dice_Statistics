import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../screens/dice_view.dart';
import '../screens/visualization_view.dart';
import '../screens/settings_view.dart';
import '../screens/sum_detail_view.dart';
import '../screens/combo_detail_view.dart';
import 'route_names.dart';
import '../widgets/bottom_nav_bar.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.diceView,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: RouteNames.diceView,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DiceView(),
            ),
          ),
          GoRoute(
            path: RouteNames.visualizationView,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: VisualizationView(),
            ),
          ),
          GoRoute(
            path: RouteNames.settingsView,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsView(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.sumDetailView,
        builder: (context, state) {
          final sum = state.extra as int;
          return SumDetailView(sum: sum);
        },
      ),
      GoRoute(
        path: RouteNames.comboDetailView,
        builder: (context, state) {
          final combo = state.extra as (int, int);
          return ComboDetailView(combo: combo);
        },
      ),
    ],
  );
});

class ScaffoldWithNavBar extends ConsumerWidget {
  final Widget child;

  const ScaffoldWithNavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const BottomNavBar(),
      // Removed the floating action button
    );
  }
}