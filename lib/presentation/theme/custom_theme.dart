import 'package:audio_app/data/colors.dart';
import 'package:flutter/material.dart';

// Define a custom theme
ThemeData customTheme() {
  return ThemeData(
    // Set the global font for the entire app
    fontFamily: 'UniNeue',

    // Primary colors for the theme
    primaryColor: widgetColor, // Color for AppBar and other elements
    hintColor: widgetColor
        .withOpacity(0.8), // Secondary color (for buttons and accents)

    // Text styling
    textTheme: const TextTheme(
      // DISPLAY LARGE
      displayLarge: TextStyle(
        fontFamily: 'UniNeue',
        fontWeight: FontWeight.w700, // Bold font
        fontSize: 36, // Font size
        color: fontColor, // Text color
      ),

      // BODY LARGE
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w600, // Normal font
        fontSize: 24, // Font size
        color: fontColor, // Text color
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w500, // Normal font
        fontSize: 18, // Font size
        color: fontColor, // Text color
      ),

      // BODY SMALL
      bodySmall: TextStyle(
        fontWeight: FontWeight.w300, // Light font
        fontSize: 12, // Font size
        color: fontColor, // Text color
      ),
    ),

    // Button styling
    buttonTheme: const ButtonThemeData(
      buttonColor: widgetColor, // Button color
      textTheme: ButtonTextTheme.primary, // Text color on buttons
    ),

    // Additional settings
    scaffoldBackgroundColor: bgColor, // Background color for the main screen
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue, // Background color for AppBar
      titleTextStyle: TextStyle(
        color: fontColor, // Text color for AppBar title
        fontSize: 20, // Font size for AppBar title
      ),
    ),
  );
}
