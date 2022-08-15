import 'package:flutter/material.dart';

const lightFillColor = Colors.black;
const darkFillColor = Colors.white;
ColorScheme get lightColorScheme => const ColorScheme(
      primary: Color(0xffff659d),
      primaryContainer: Color.fromRGBO(17, 115, 120, 1),
      secondary: Colors.black,
      secondaryContainer: Color(0xFFFAFBFB),
      background: Colors.white,
      surface: Colors.black,
      onBackground: Colors.white,
      error: lightFillColor,
      onError: lightFillColor,
      onPrimary: lightFillColor,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      brightness: Brightness.light,
    );

ColorScheme get darkColorScheme => const ColorScheme(
      primary: Color(0xFFFF8383),
      primaryContainer: Color(0xFF1CDEC9),
      secondary: Color(0xFF4D1F7C),
      secondaryContainer: Color(0xFF451B6F),
      background: Color(0xFF241E30),
      surface: Color(0xFF1F1929),
      onBackground: Color(0x0DFFFFFF), // White with 0.05 opacity
      error: darkFillColor,
      onError: darkFillColor,
      onPrimary: darkFillColor,
      onSecondary: darkFillColor,
      onSurface: darkFillColor,
      brightness: Brightness.dark,
    );
