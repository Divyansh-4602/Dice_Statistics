import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dice_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/custom_switch.dart';
import 'package:flutter/material.dart' hide ThemeMode;
import '../providers/theme_provider.dart' as my_theme;

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diceState = ref.watch(diceProvider).current;
    final diceNotifier = ref.read(diceProvider.notifier);
    final themeNotifier = ref.read(themeProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Equal Distribution',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              CustomSwitch(
                value: diceState.equalDistribution,
                onChanged: (value) {
                  diceNotifier.setEqualDistribution(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dark Mode',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              CustomSwitch(
                value: ref.watch(themeProvider) == AppThemeMode.dark,
                onChanged: (value) {
                  themeNotifier.state = value ? my_theme.AppThemeMode.dark : my_theme.AppThemeMode.light;
                },
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Reset Data'),
                  content: const Text(
                      'Are you sure you want to reset all statistics?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              );
              if (confirmed == true) {
                diceNotifier.reset();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Reset All Data'),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}