import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'dimens.dart';

ThemeData appTheme = ThemeData(
  primaryColor: ThemeColors.primaryColor,
  disabledColor: ThemeColors.disableTextColor,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: ThemeColors.primaryColorDark,
    ),
    color: ThemeColors.white,
    iconTheme: IconThemeData(color: ThemeColors.textColor),
  ),
  textTheme: TextTheme(
    bodyText1: GoogleFonts.poppins(
      color: ThemeColors.textColor,
      fontSize: 15,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: ThemeColors.primaryColor,
    selectionHandleColor: ThemeColors.primaryColor,
  ),
  backgroundColor: ThemeColors.backgroundColor,
  scaffoldBackgroundColor: ThemeColors.primaryColor,
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.fromLTRB(20, 24, 12, 16),
    hintStyle: GoogleFonts.poppins(
      color: ThemeColors.disableTextColor,
    ),
    errorStyle: GoogleFonts.poppins(
      fontSize: 12,
      color: ThemeColors.errorColor,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: ThemeColors.greyLight,
        width: ThemeDimensSize.xxSmallSpace - 0.8,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: ThemeColors.primaryColor,
        width: ThemeDimensSize.xxSmallSpace + 0.25,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: ThemeColors.greyLight,
        width: ThemeDimensSize.xxSmallSpace - 0.8,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: ThemeColors.errorColor,
        width: ThemeDimensSize.xxSmallSpace,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: ThemeColors.errorColor,
        width: ThemeDimensSize.xxSmallSpace,
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: ThemeColors.secondaryColor,
  ),
);
