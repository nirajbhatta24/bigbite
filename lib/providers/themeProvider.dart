import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _theme = ThemeData.dark();
  ThemeData get theme => _theme;

  void toggleTheme() {
    final isDark_theme = _theme == ThemeData.dark();

    if (isDark_theme) {
      _theme = ThemeData.light();
    } else {
      _theme = ThemeData.dark();
    }
    notifyListeners();
  }
}
