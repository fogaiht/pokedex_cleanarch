import 'package:flutter/material.dart';

class ThemeColors {
  const ThemeColors._();

  static const Color primaryColor = Color(0xFFCE2211);
  static const Color primaryColorDark = Color(0xFF2E6341);
  static const Color textColor = Color(0xFF373737);
  static final Color disableTextColor = textColor.withOpacity(0.5);
  static const Color errorColor = Color(0xFFE34F4F);
  static const Color white = Color(0xFFFFFFFF);
  static const Color disableColor = Color(0xFFE0E0E0);
  static const Color greyBorder = Color(0xFFE0E0E0);

  static const Color secondaryColor = Color(0xFFFFCC00);
  static const Color backgroundColor = Color(0xFFF9F9F9);
  static const Color disableButtonColor = Color(0xFFBBBBBB);
  static const Color blueDescription = Color(0xFF00B1FF);

  static const Color black = Color(0xFF000000);
  static const Color greyLight = Color(0xFFAFAFAF);
  static const Color transparent = Color(0x00000000);

  static const Color alertInfoColor = Color(0xffee9d01);
  static const Color alertSuccessColor = Color(0xff63b180);
  static const Color alertErrorColor = Color(0xffE34F4F);
  static const Color alertQuestionColor = Color.fromARGB(255, 58, 134, 206);
}
