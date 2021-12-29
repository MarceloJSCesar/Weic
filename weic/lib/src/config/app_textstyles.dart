import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  static final TextStyle dadosEssenciaisButtonTextStyle =
      GoogleFonts.notoSans(fontSize: 16, color: Colors.white);
}
