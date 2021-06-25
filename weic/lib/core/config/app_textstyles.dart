import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final TextStyle dropDownTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 15,
  );
  static final TextStyle hintTextStyle = TextStyle(
    color: Colors.grey,
    fontSize: 15,
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
}
