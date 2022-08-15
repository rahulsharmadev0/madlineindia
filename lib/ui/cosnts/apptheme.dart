import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_scheme.dart';

FontWeight get regular => FontWeight.w400;
FontWeight get medium => FontWeight.w500;
FontWeight get semiBold => FontWeight.w600;
FontWeight get bold => FontWeight.w700;

class AppThemeData {
  static final Color _lightFocusColor = lightFillColor.withOpacity(0.12);
  static final Color _darkFocusColor = darkFillColor.withOpacity(0.12);

  static ThemeData lightThemeData = themeData(
      lightColorScheme,
      _lightFocusColor,
      style.copyWith(
          bodyText1: const TextStyle(color: darkFillColor),
          subtitle1: const TextStyle(color: darkFillColor)));

  static ThemeData darkThemeData = themeData(
      darkColorScheme,
      _darkFocusColor,
      style.copyWith(
          bodyText1: const TextStyle(color: lightFillColor),
          subtitle1: const TextStyle(color: lightFillColor)));

  static ThemeData themeData(
          ColorScheme colorScheme, Color focusColor, TextTheme textTheme) =>
      ThemeData(
        // For Web
        pageTransitionsTheme: kIsWeb ? NoTransitionsOnWeb() : null,
        colorScheme: colorScheme,
        textTheme: textTheme,
        fontFamily: GoogleFonts.raleway().fontFamily,

        // Matches manifest.json colors and background color.
        primaryColor: colorScheme.secondary,
        appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: colorScheme.secondary,
            iconTheme: IconThemeData(color: colorScheme.primary)),
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
        canvasColor: colorScheme.background,
        scaffoldBackgroundColor: colorScheme.background,
        highlightColor: Colors.transparent,
        focusColor: focusColor,
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor:
              Color.alphaBlend(lightFillColor.withOpacity(0.80), darkFillColor),
          contentTextStyle: textTheme.subtitle1!.apply(color: darkFillColor),
        ),
      );
}

TextTheme get style => TextTheme(
      // bodyText
      bodyText1: TextStyle(fontWeight: regular, fontSize: 16.0),
      bodyText2: TextStyle(fontWeight: regular, fontSize: 16.0),

      // subtitle
      subtitle1: GoogleFonts.raleway(fontWeight: semiBold, fontSize: 14.0),
      subtitle2: GoogleFonts.raleway(fontWeight: semiBold, fontSize: 14.0),

      // headline
      headline1: GoogleFonts.raleway(
          fontWeight: bold, fontSize: 36.0, color: Colors.black),
      headline2: GoogleFonts.raleway(
          fontWeight: bold, fontSize: 32.0, color: Colors.black),
      headline3: GoogleFonts.raleway(
          fontWeight: bold, fontSize: 28.0, color: Colors.black),
      headline4: GoogleFonts.raleway(
          fontWeight: bold, fontSize: 24.0, color: Colors.black),
      headline5: GoogleFonts.raleway(
          fontWeight: bold, fontSize: 20.0, color: Colors.black),
      headline6: GoogleFonts.raleway(
          fontWeight: bold, fontSize: 16.0, color: Colors.black),

      // other
      caption: GoogleFonts.raleway(fontWeight: medium, fontSize: 12.0),
      overline: GoogleFonts.raleway(fontWeight: medium, fontSize: 12.0),
      button: GoogleFonts.raleway(fontWeight: semiBold, fontSize: 14.0),
    );

class NoTransitionsOnWeb extends PageTransitionsTheme {
  @override
  Widget buildTransitions<T>(
    route,
    context,
    animation,
    secondaryAnimation,
    child,
  ) {
    if (kIsWeb) {
      return child;
    }
    return super.buildTransitions(
      route,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
