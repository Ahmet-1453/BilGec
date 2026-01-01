import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF3F51B5);
  static const Color accentColor = Color(0xFFFF9800);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color scaffoldBg = Color(0xFFF5F7FA);

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: scaffoldBg,
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
    ),
    
  );
}