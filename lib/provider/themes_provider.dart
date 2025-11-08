import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    loadTheme();
  }

  void loadTheme() {
    final box = Hive.box('settingsBox');
    final stored = box.get('themeMode', defaultValue: 'system');
    state = _stringToThemeMode(stored);
  }

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    Hive.box('settingsBox').put('themeMode', _themeModeToString(state));
  }

  String _themeModeToString(ThemeMode mode) =>
      mode == ThemeMode.light ? 'light' : mode == ThemeMode.dark ? 'dark' : 'system';

  ThemeMode _stringToThemeMode(String value) =>
      value == 'light' ? ThemeMode.light : value == 'dark' ? ThemeMode.dark : ThemeMode.system;
}
