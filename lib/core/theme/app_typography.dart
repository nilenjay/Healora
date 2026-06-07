import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static final TextStyle headlineLarge =
  GoogleFonts.manrope(
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle headlineMedium =
  GoogleFonts.manrope(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle bodyLarge =
  GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle bodyMedium =
  GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle labelMedium =
  GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}