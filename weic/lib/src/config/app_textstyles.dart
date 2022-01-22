import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weic/src/config/app_colors.dart';

class AppTextStyles {
  static final TextStyle dropDownTextStyle = GoogleFonts.notoSans(
    color: Colors.white,
    fontSize: 17,
  );
  static final TextStyle hintTextStyle = GoogleFonts.notoSans(
    color: Colors.grey,
    fontSize: 17,
  );
  static final TextStyle title = GoogleFonts.notoSans(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle titleBold = GoogleFonts.notoSans(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle blackTextStyle = GoogleFonts.amiri(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static final TextStyle titleBlackTextStyle = GoogleFonts.adventPro(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );
  static final TextStyle homeNoticiasTitleTextStyle = GoogleFonts.notoSans(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle homeNoticiasCardTitleTextStyle = GoogleFonts.notoSans(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle homeViewerNoticiasTitleTextStyle =
      GoogleFonts.notoSans(
    fontSize: 17,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle homeViewerNoticiasBodyTextStyle = GoogleFonts.notoSans(
    fontSize: 16,
    color: Colors.black.withOpacity(0.6),
  );
  static final TextStyle dadosEssenciaisButtonTextStyle = GoogleFonts.notoSans(
    fontSize: 16,
    color: Colors.white,
  );
  // profile view
  static final TextStyle esadTextStyle = GoogleFonts.notoSans(
    fontSize: 16,
    color: AppColors.esadColor,
  );
  static final TextStyle studentNameTextStyle = GoogleFonts.notoSans(
    fontSize: 16,
    color: Colors.black,
  );
  static final TextStyle cardFollowsTextStyle = GoogleFonts.notoSans(
    fontSize: 17,
    color: Colors.white,
    fontWeight: FontWeight.normal,
  );
  static final TextStyle cardNumFollowsTextStyle = GoogleFonts.notoSans(
    fontSize: 17,
    color: Colors.grey,
  );
  static final TextStyle profileTitleTextStyle = GoogleFonts.notoSans(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  // chat view
  static final TextStyle chatTabTitleTextStyle = GoogleFonts.notoSans(
    fontSize: 18,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle studentCardButtonTextStyle = GoogleFonts.notoSans(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.normal,
  );
  //  profile
  final TextStyle snackbarTextButtonTextStyle = GoogleFonts.notoSans(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.normal,
  );
  // student search
  static final TextStyle searchStudentFieldTextStyle = GoogleFonts.notoSans(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );
}
