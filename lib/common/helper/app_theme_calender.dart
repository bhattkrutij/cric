import 'package:flutter/material.dart';

commonAppThemeForCalender() {
  return ThemeData(
    primaryColor: Color(0xFF4CAF50), // Your primary color
    hintColor: Color(0xFF4CAF50), // Use primary color for accent as well
    splashColor: Colors.green.withOpacity(0.2), // Light green for splash effect
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary, // Ensures button text color is readable
    ),
    // textTheme: TextTheme(
    //   headline6: TextStyle(color: Colors.black), // Calendar header text
    //   bodyText2: TextStyle(color: Colors.black), // Day text
    // ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF4CAF50), // Primary color for the calendar header
      onPrimary: Colors.white, // Text color on primary color
      onSurface: Colors.black, // Text color on surface elements
      surface: Colors.white, // Background color of the date picker
    ),
    dialogBackgroundColor: Colors.white, // Background color of the dialog
  );
}