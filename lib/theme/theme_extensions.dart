import 'package:flutter/material.dart' hide ButtonStyle;

import 'app_theme.dart';

extension MyThemeExtension on ThemeData {
  AppStyle get appStyle => extension<AppStyle>()!;
}