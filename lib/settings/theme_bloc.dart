import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_state.dart';

class ThemeBloc extends Cubit<ThemeState> {
  static const String _themeModeKey = 'theme_mode';

  ThemeBloc() : super(ThemeState(themeData: _lightTheme, isDarkMode: false)) {
    _loadTheme(); // Load theme from SharedPreferences
  }

//**********************************************************************
  static final ThemeData _lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF1F8E9),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF4CAF50),
      foregroundColor: Colors.white,
      centerTitle: true,
      toolbarHeight: 45,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: Colors.white, fontSize: 14),
      bodySmall: TextStyle(color: Colors.white, fontSize: 14),
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      textColor: Colors.black,
      collapsedTextColor: Colors.black,
    ),
    listTileTheme: const ListTileThemeData(
      titleTextStyle: TextStyle(fontSize: 14, color: Colors.black),
      // textColor: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
      ),
    ),
    switchTheme: SwitchThemeData(
      trackOutlineColor: WidgetStateProperty.all(Colors.green),
      thumbIcon: WidgetStateProperty.all(const Icon(Icons.light_mode)),
      thumbColor: WidgetStateProperty.all(Colors.green)
    ),
    radioTheme:  RadioThemeData(
      fillColor: WidgetStateProperty.all(Colors.green), // Set the color here
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF4CAF50),
      foregroundColor: Colors.white,
      shape: CircleBorder(),
    ),
  );

//**************************************************************************
  static final ThemeData _darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF303030),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF4CAF50),
      foregroundColor: Colors.white,
      centerTitle: true,
      toolbarHeight: 45,
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: Color(0xFF303030),
    ),
    textTheme: const TextTheme(
      displayMedium: TextStyle(color: Colors.white, fontSize: 16),
      displaySmall: TextStyle(color: Colors.white, fontSize: 16),
      displayLarge: TextStyle(color: Colors.white, fontSize: 20),
      labelLarge: TextStyle(color: Colors.white, fontSize: 14),
      labelMedium: TextStyle(color: Colors.white, fontSize: 14),
      labelSmall: TextStyle(color: Colors.white, fontSize: 14),
      headlineLarge: TextStyle(color: Colors.white, fontSize: 20),
      headlineMedium: TextStyle(color: Colors.white, fontSize: 16),
      headlineSmall: TextStyle(color: Colors.white, fontSize: 16),
      titleLarge: TextStyle(color: Colors.white, fontSize: 20),
      titleMedium: TextStyle(color: Colors.white, fontSize: 14),
      titleSmall: TextStyle(color: Colors.white, fontSize: 16),
      bodyLarge: TextStyle(color: Colors.white, fontSize: 20),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
      bodySmall: TextStyle(color: Colors.white, fontSize: 14),
    ),
    radioTheme:  RadioThemeData(
      fillColor: WidgetStateProperty.all(Colors.red),
    ),
    switchTheme: SwitchThemeData(
      thumbIcon: WidgetStateProperty.all(const Icon(Icons.dark_mode, color: Colors.white,)),
      thumbColor: WidgetStateProperty.all(Colors.red),
      trackOutlineColor: WidgetStateProperty.all(Colors.red),
      trackColor: WidgetStateProperty.all(Color(0xFF303030))
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      textColor: Colors.white,
      collapsedTextColor: Colors.white,
    ),
    listTileTheme: const ListTileThemeData(
      textColor: Colors.white,
      titleTextStyle: TextStyle(fontSize: 14, ),
      // textColor: Colors.white,
    ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.black, // Color for the label
        ),
      ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF4CAF50),
      foregroundColor: Colors.white,
      shape: CircleBorder(),
    ),
  );

  void toggleTheme() async {
    final isDark = state.isDarkMode;
    emit(ThemeState(
      themeData: isDark ? _lightTheme : _darkTheme,
      isDarkMode: !isDark,
    ));
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themeModeKey, !isDark);
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themeModeKey) ?? false;
    emit(ThemeState(
      themeData: isDark ? _darkTheme : _lightTheme,
      isDarkMode: isDark,
    ));
  }
}
