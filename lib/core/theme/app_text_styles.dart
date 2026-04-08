import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roasters/core/theme/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // === Dosis ExtraBold ===

  static TextStyle dosisExtraBold48({Color? color}) => GoogleFonts.dosis(
    fontSize: 48.spMin,
    fontWeight: FontWeight.w800,
    color: color ?? AppColors.textPrimaryDark,
    letterSpacing: -1.w,
  );

  static TextStyle dosisExtraBold32({Color? color}) => GoogleFonts.dosis(
    fontSize: 32.spMin,
    fontWeight: FontWeight.w800,
    color: color ?? AppColors.textPrimaryDark,
    letterSpacing: -0.5.w,
  );


  // === Fira Sans Medium ===

  static TextStyle firaMedium24({Color? color}) => GoogleFonts.firaSans(
    fontSize: 24.spMin,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.textPrimaryDark,
  );

  static TextStyle firaMedium18({Color? color}) => GoogleFonts.firaSans(
    fontSize: 18.spMin,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.textPrimaryLight,
  );//
  static TextStyle firaMedium16({Color? color}) => GoogleFonts.firaSans(
    fontSize: 16.spMin,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.text,
  );
  static TextStyle firaMedium14({Color? color}) => GoogleFonts.firaSans(
    fontSize: 14.spMin,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.text,
  );//

  // === Fira Sans Small Bold ===

  static TextStyle firaBold16({Color? color}) => GoogleFonts.firaSans(
    fontSize: 16.spMin,
    fontWeight: FontWeight.w700,
    color: color ?? AppColors.textPrimaryLight,
  );
  static TextStyle firaBold18({Color? color}) => GoogleFonts.firaSans(
    fontSize: 18.spMin,
    fontWeight: FontWeight.w700,
    color: color ?? AppColors.textPrimaryLight,
  );
  static TextStyle firaBold24({Color? color}) => GoogleFonts.firaSans(
    fontSize: 24.spMin,
    fontWeight: FontWeight.w700,
    color: color ?? AppColors.textPrimaryLight,
  );

  // === Button Style  ===
  static TextStyle button({Color? color}) => GoogleFonts.firaSans(
    fontSize: 24.spMin,
    fontWeight: FontWeight.w700,
    color: color ?? Colors.white,
  );

  // === Caption / Small Text ===
  static TextStyle caption({Color? color}) => GoogleFonts.firaSans(
    fontSize: 12.spMin,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.divider,
  );
}