import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const _yellowPrimaryValue = 0xFFFFD700;
  static const MaterialColor yellow =MaterialColor(_yellowPrimaryValue, <int, Color>{
    50: Color(0xFFFFFDE7),
    100: Color(0xFFFFF9C4),
    200: Color(0xFFFFF59D),
    300: Color(0xFFFFF176),
    400: Color(0xFFFFEE58),
    500: Color(_yellowPrimaryValue),
    600: Color(0xFFFFEB3B),
    700: Color(0xFFFDD835),
    800: Color(0xFFFBC02D),
    900: Color(0xFFF9A825),
  },); 

  static const _greenPrimaryValue = 0xFF4CAF50;
  static const MaterialColor green =MaterialColor(_greenPrimaryValue, <int, Color>{
    50: Color(0xFFE8F5E9),
    100: Color(0xFFC8E6C9),
    200: Color(0xFFA5D6A7),
    300: Color(0xFF81C784),
    400: Color(0xFF66BB6A),
    500: Color(_greenPrimaryValue),
    600: Color(0xFF43A047),
    700: Color(0xFF388E3C),
    800: Color(0xFF2E7D32),
    900: Color(0xFF1B5E20),
  },);

  static const _brownPrimaryValue = 0xFF5C210B;
  static const MaterialColor brown =MaterialColor(_brownPrimaryValue, <int, Color>{
    50: Color(0xFFEFEBE9),
    100: Color(0xFFD7CCC8),
    200: Color(0xFFBCAAA4),
    300: Color(0xFFA1887F),
    400: Color(0xFF8D6E63),
    500: Color(_brownPrimaryValue),
    600: Color(0xFF6D4C41),
    700: Color(0xFF5D4037),
    800: Color(0xFF4E342E),
    900: Color(0xFF3E2723),
  },); 

  static const _bluePrimaryValue = 0xFF2196F3;
  static const MaterialColor blue =MaterialColor(_bluePrimaryValue, <int, Color>{
    50: Color(0xFFE3F2FD),
    100: Color(0xFFBBDEFB),
    200: Color(0xFF90CAF9),
    300: Color(0xFF64B5F6),
    400: Color(0xFF42A5F5),
    500: Color(_bluePrimaryValue),
    600: Color(0xFF1E88E5),
    700: Color(0xFF1976D2),
    800: Color(0xFF1565C0),
    900: Color(0xFF0D47A1),
  },); 

  static const _whitePrimaryValue = 0xFFFFFFFF;
  static const MaterialColor white =MaterialColor(_whitePrimaryValue, <int, Color>{
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF5F5F5),
    200: Color(0xFFEEEEEE),
    300: Color(0xFFE0E0E0),
    400: Color(0xFFBDBDBD),
    500: Color(_whitePrimaryValue),
    600: Color(0xFF757575),
    700: Color(0xFF616161),
    800: Color(0xFF424242),
    900: Color(0xFF212121),
  },);

  static const _deepPurplePrimaryValue = 0xFF673AB7; 
  static const MaterialColor deepPurple =MaterialColor(_deepPurplePrimaryValue, <int, Color>{
    50: Color(0xFFEDE7F6),
    100: Color(0xFFD1C4E9),
    200: Color(0xFFB39DDB),
    300: Color(0xFF9575CD),
    400: Color(0xFF7E57C2),
    500: Color(_deepPurplePrimaryValue),
    600: Color(0xFF5E35B1),
    700: Color(0xFF512DA8),
    800: Color(0xFF4527A0),
    900: Color(0xFF311B92),
  },);

 /* static ThemeData lightTheme = ThemeData(
    primarySwatch: yellow,
    primaryColor: yellow,
    hintColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black), toolbarTextStyle: const TextTheme(
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ).bodyText2, titleTextStyle: const TextTheme(
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ).headline6,
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primarySwatch: deepPurple,
    primaryColor: deepPurple,
    hintColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white), toolbarTextStyle: const TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ).bodyText2, titleTextStyle: const TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ).headline6,
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
  );*/
}