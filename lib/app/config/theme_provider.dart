import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late SharedPreferences preferences;
  static const String _keyTheme = 'isDarkMode';
  bool _isDarkMode = false;

  ThemeProvider() {
    _loadTheme();
  }

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    preferences.setBool(_keyTheme, _isDarkMode);
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    preferences = await SharedPreferences.getInstance();
    _isDarkMode = preferences.getBool(_keyTheme) ?? false;
    notifyListeners();
  }
}
