import 'package:flutter/material.dart';

// TODO: Extract all color values to const variables
ThemeData mainTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,

      // Prefix the HEX value with "0xff" to automagically convert to int

      // Primary from Brand
      primary: Color(0xff58A6BE),
      onPrimary: Colors.white,

      // Orange from Brand
      secondary: Color(0xffF1824A),
      onSecondary: Colors.white,

      // Yellow from Brand
      tertiary: Color(0xffF1BC58),
      onTertiary: Colors.white,

      // Error from Semantic
      error: Color(0xffE8434D),
      onError: Colors.white,

      // PrimaryDark from Utility Dark
      background: Color(0xff14151D),
      // PrimaryTextDark from Utility Dark
      onBackground: Color(0xffF6FBFF),

      // SecondaryDark from Utility Dark
      surface: Color(0xff121216),
      // SecondaryTextDark from Utility Dark
      onSurface: Color(0xff95A1AC),

      // TertiaryDark from Utility Dark
      surfaceVariant: Color(0xff36373E),
      // SecondaryTextDark from Utility Dark
      onSurfaceVariant: Color(0xff95A1AC),
    ),
    textTheme: TextTheme());
