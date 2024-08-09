import 'package:flutter/material.dart';

import '../../constant/color.dart';

class MyTextTheme {
  MyTextTheme._();

  static double _getResponsiveFontSize(BuildContext context, double fontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    return fontSize * screenWidth / 375.0;
  }

  static TextTheme lightTextTheme(BuildContext context) => TextTheme(
        titleLarge: TextStyle(
            fontFamily: "Quicksand",
            color: textColor,
            fontSize: _getResponsiveFontSize(context, 34),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        titleMedium: TextStyle(
            fontFamily: "Quicksand",
            color: textColor,
            fontSize: _getResponsiveFontSize(context, 28),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        titleSmall: TextStyle(
            fontFamily: "Quicksand",
            color: textColor,
            fontSize: _getResponsiveFontSize(context, 22),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        headlineLarge: TextStyle(
            fontFamily: "Quicksand",
            color: textColor,
            fontSize: _getResponsiveFontSize(context, 28),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        headlineMedium: TextStyle(
            fontFamily: "Quicksand",
            color: textColor,
            fontSize: _getResponsiveFontSize(context, 22),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        headlineSmall: TextStyle(
            fontFamily: "Quicksand",
            color: textColor,
            fontSize: _getResponsiveFontSize(context, 18),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        displayLarge: TextStyle(
            fontFamily: "Quicksand",
            color: textColor,
            fontSize: _getResponsiveFontSize(context, 34),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        displayMedium: TextStyle(
            fontFamily: "Quicksand",
            color: textColor,
            fontSize: _getResponsiveFontSize(context, 28),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        displaySmall: TextStyle(
            fontFamily: "Quicksand",
            color: textColor,
            fontSize: _getResponsiveFontSize(context, 22),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        labelLarge: TextStyle(
            fontFamily: "Quicksand",
            color: textColor,
            fontSize: _getResponsiveFontSize(context, 18),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        labelMedium: TextStyle(
            fontFamily: "Quicksand",
            color: textColor,
            fontSize: _getResponsiveFontSize(context, 16),
            fontWeight: FontWeight.w600, // Medium emphasis
            letterSpacing: 0),
        labelSmall: TextStyle(
            fontFamily: "Quicksand",
            color: textColor,
            fontSize: _getResponsiveFontSize(context, 14),
            fontWeight: FontWeight.w500, // Medium emphasis
            letterSpacing: 0),
      );

  static TextTheme darkTextTheme(BuildContext context) => TextTheme(
        titleLarge: TextStyle(
            fontFamily: "Quicksand",
            color: textDarkColor,
            fontSize: _getResponsiveFontSize(context, 34),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        titleMedium: TextStyle(
            fontFamily: "Quicksand",
            color: textDarkColor,
            fontSize: _getResponsiveFontSize(context, 28),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        titleSmall: TextStyle(
            fontFamily: "Quicksand",
            color: textDarkColor,
            fontSize: _getResponsiveFontSize(context, 22),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        headlineLarge: TextStyle(
            fontFamily: "Quicksand",
            color: textDarkColor,
            fontSize: _getResponsiveFontSize(context, 28),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        headlineMedium: TextStyle(
            fontFamily: "Quicksand",
            color: textDarkColor,
            fontSize: _getResponsiveFontSize(context, 22),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        headlineSmall: TextStyle(
            fontFamily: "Quicksand",
            color: textDarkColor,
            fontSize: _getResponsiveFontSize(context, 18),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        displayLarge: TextStyle(
            fontFamily: "Quicksand",
            color: textDarkColor,
            fontSize: _getResponsiveFontSize(context, 34),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        displayMedium: TextStyle(
            fontFamily: "Quicksand",
            color: textDarkColor,
            fontSize: _getResponsiveFontSize(context, 28),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        displaySmall: TextStyle(
            fontFamily: "Quicksand",
            color: textDarkColor,
            fontSize: _getResponsiveFontSize(context, 22),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        labelLarge: TextStyle(
            fontFamily: "Quicksand",
            color: textDarkColor,
            fontSize: _getResponsiveFontSize(context, 18),
            fontWeight: FontWeight.w700, // High emphasis
            letterSpacing: 0),
        labelMedium: TextStyle(
            fontFamily: "Quicksand",
            color: textDarkColor,
            fontSize: _getResponsiveFontSize(context, 16),
            fontWeight: FontWeight.w600, // Medium emphasis
            letterSpacing: 0),
        labelSmall: TextStyle(
            fontFamily: "Quicksand",
            color: textDarkColor,
            fontSize: _getResponsiveFontSize(context, 14),
            fontWeight: FontWeight.w500, // Medium emphasis
            letterSpacing: 0),
      );
}
