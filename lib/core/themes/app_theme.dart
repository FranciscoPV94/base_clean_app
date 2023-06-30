import 'package:default_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

final theme = ThemeData(
    useMaterial3: true,
    primaryColor: const Color.fromARGB(255, 0, 97, 153),
    primaryColorLight: const Color(0xffffffff),
    primaryColorDark: const Color(0xff5E6278),
    hintColor: const Color(0xffA4A5B7),
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 190, 207, 230),
      surface: Color(0xff47be7d),
      secondary: Color(0xffE1E3EA),
      error: Color(0xfff1416c),
      background: Color(0xffF2F6F8),
    ),
    scaffoldBackgroundColor: const Color(0xffF2F6F8),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(fontWeight: FontWeight.bold),
      fillColor: const Color(0xffF2F6F8),
      errorStyle: const TextStyle(color: Color(0xfff1416c)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          width: 0.8,
          color: Color(0xffA4A5B7),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
        borderSide: const BorderSide(width: 1.2, color: Color(0xffA4A5B7)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
        borderSide: const BorderSide(
          width: 0.8,
          color: Color(0xfff1416c),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
        borderSide: const BorderSide(
          width: 1.2,
          color: Color(0xfff1416c),
        ),
      ),
    ),
    textTheme: const TextTheme(
        headlineLarge:
            TextStyle(fontWeight: FontWeight.bold, color: Color(0xff181C32)),
        bodySmall:
            TextStyle(fontWeight: FontWeight.bold, color: Color(0xffA4A5B7))));
