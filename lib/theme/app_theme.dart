import 'package:flutter/material.dart';
import 'package:todo_list/utils/constants.dart';

part 'app_style.dart';

class AppTheme {
  const AppTheme._();

  static const _designFileWidth = 375;
  static final _deviceWidth = MediaQueryData.fromWindow(
    WidgetsBinding.instance.window,
  ).size.width;

  static double getAdaptiveSize(double size) =>
      size * _deviceWidth / _designFileWidth;

  static const _defaultElevation = 2.5;

  static ThemeData _baseTheme(
    Brightness brightness, {
    Color? textColor,
    Color? accentColor,
    Color? onAccentColor,
    Color? scaffoldBackgroundColor,
  }) {
    late final ColorScheme defaultColorScheme;

    switch (brightness) {
      case Brightness.light:
        defaultColorScheme = const ColorScheme.light();
        textColor ??= Colors.black;
        break;
      case Brightness.dark:
        defaultColorScheme = const ColorScheme.dark();
        textColor ??= Colors.white;
        break;
    }

    final iconThemeData = IconThemeData(color: accentColor);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      iconTheme: iconThemeData,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: _defaultElevation,
        color: Colors.transparent,
        iconTheme: iconThemeData.copyWith(color: textColor),
        actionsIconTheme: iconThemeData,
        titleTextStyle: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: getAdaptiveSize(20),
        ),
      ),
      colorScheme: defaultColorScheme.copyWith(
        brightness: brightness,
        primary: accentColor,
        onPrimary: onAccentColor ?? textColor,
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
      ),
      splashFactory: InkSparkle.splashFactory,
      bottomSheetTheme: BottomSheetThemeData(
        modalElevation: 10,
        backgroundColor: scaffoldBackgroundColor,
        modalBackgroundColor: scaffoldBackgroundColor,
      ),
      snackBarTheme: SnackBarThemeData(
        elevation: _defaultElevation,
        contentTextStyle: TextStyle(
          fontSize: getAdaptiveSize(14),
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
          TargetPlatform.values,
          value: (_) => const CupertinoPageTransitionsBuilder(),
        ),
      ),
    );
  }

  static final lightTheme =
      _baseTheme(
        Brightness.dark,
        accentColor: const Color(0xFF3A96FF),
        onAccentColor: Colors.white,
        scaffoldBackgroundColor: secondaryWhite,
      ).copyWith(
        extensions: <ThemeExtension>{AppStyle._darkTheme()},
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFF111111),
          elevation: _defaultElevation,
          selectedItemColor: const Color(0xFF3A96FF),
          unselectedItemColor: const Color(0xFF707070),
          selectedLabelStyle: TextStyle(
            fontSize: getAdaptiveSize(11),
            color: const Color(0xFF3A96FF),
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: getAdaptiveSize(11),
            color: const Color(0xFF707070),
          ),
          type: BottomNavigationBarType.fixed,
        ),
        dividerTheme: DividerThemeData(
          color: Colors.black,
          space: 1,
          thickness: 0.25,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: getAdaptiveSize(32),
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          displayMedium: TextStyle(
            fontSize: getAdaptiveSize(18),
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          displaySmall: TextStyle(
            fontSize: getAdaptiveSize(16),
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          headlineMedium: TextStyle(
            fontSize: getAdaptiveSize(25),
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          headlineLarge: TextStyle(
            fontSize: getAdaptiveSize(30),
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: TextStyle(
            fontSize: getAdaptiveSize(14),
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          titleLarge: TextStyle(
            fontSize: getAdaptiveSize(12),
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: TextStyle(
            fontSize: getAdaptiveSize(16),
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
          hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
          filled: true,
          fillColor: secondaryWhite,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      );
}
