import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static TextStyle title28 = GoogleFonts.openSans(
    fontWeight: FontWeight.w500,
    fontSize: 28,
  );
  static TextStyle title22 = title28.copyWith(fontSize: 22);
  static final title20 = title28.copyWith(fontSize: 20);
  static final regular18 = title28.copyWith(fontSize: 18);
  static TextStyle regular16 = GoogleFonts.openSans(
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static final regular15 = regular16.copyWith(fontSize: 15);
  static final regular14 = regular16.copyWith(
    fontSize: 14,
  );
  static final regular14White = regular16.copyWith(
    fontSize: 14,
    color: primaryWhite,
  );
  static final regular12 = regular16.copyWith(
    fontSize: 12,
  );

  static final title11 = regular16.copyWith(
    fontSize: 11,
  );
}
