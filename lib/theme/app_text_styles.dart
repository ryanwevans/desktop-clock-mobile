import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  static TextStyle calendarDate(double fontSize) {
    return TextStyle(
      color: AppColors.calendarDay,
      fontSize: fontSize,
      fontWeight: FontWeight.w300,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }

  static TextStyle digitalClockTime(double fontSize) {
    return TextStyle(
      color: AppColors.calendarDay,
      fontSize: fontSize,
      fontWeight: FontWeight.w100,
      height: 0.78,
      letterSpacing: 0,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }
}
