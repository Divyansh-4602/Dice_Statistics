import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppThemeMode { light, dark }

final themeProvider = StateProvider<AppThemeMode>((ref) => AppThemeMode.light);