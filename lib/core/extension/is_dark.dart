import 'package:flutter/material.dart';

extension IsDarkMode on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}
