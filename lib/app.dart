import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routing/app_router.dart';
import 'providers/theme_provider.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final appThemeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Dice Simulator',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: appThemeMode == AppThemeMode.dark
          ? ThemeMode.dark
          : ThemeMode.light,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0, // Prevents text scaling issues
            ),
            child: SafeArea(
              child: Scaffold(
                body: SizedBox.expand(
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}