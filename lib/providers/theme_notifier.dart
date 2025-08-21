import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../core/theme/app_theme.dart';

class ThemeNotifier extends ChangeNotifier {
  bool isDarkMode = false;
  final Box settingsBox = Hive.box('settings');

  ThemeNotifier() {
    _loadTheme();
  }

  ThemeData currentTheme(BuildContext context) =>
      isDarkMode ? AppTheme.darkTheme(context) : AppTheme.lightTheme(context);

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    settingsBox.put('isDarkMode', isDarkMode); 
    notifyListeners();
  }

  void _loadTheme() {
    if (settingsBox.containsKey('isDarkMode')) {
      
      isDarkMode = settingsBox.get('isDarkMode', defaultValue: false);
    } else {
     
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      isDarkMode = brightness == Brightness.dark;
    }
    notifyListeners();
  }
}
