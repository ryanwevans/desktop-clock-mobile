import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  static TextStyle robotoThin({
    required double fontSize,
    Color? color,
    double? height,
    double? letterSpacing,
    FontWeight? fontWeight,
    List<FontFeature>? fontFeatures,
  }) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.w100,
      color: color ?? AppColors.calendarDay,
      height: height,
      letterSpacing: letterSpacing,
      fontFeatures: fontFeatures,
    );
  }

  static TextStyle calendarDate(double fontSize) {
    return robotoThin(
      fontSize: fontSize,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }

  static TextStyle digitalClockTime(double fontSize) {
    return robotoThin(
      fontSize: fontSize,
      height: 0.78,
      letterSpacing: 0,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }
}
