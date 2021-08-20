import 'package:flutter/material.dart';

// https://uigradients.com
class BackgroundTheme {
  const BackgroundTheme();

  static const Color gradientStart = const Color(0xFF514a9d);
  static const Color gradientEnd = const Color(0xFF24c6dc);

  static const gradient = const LinearGradient(
    colors: const [gradientStart, gradientEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0, 1]
  );
}
