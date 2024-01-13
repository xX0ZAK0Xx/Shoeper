import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appStyle(Color c, double s, FontWeight f) {
  return GoogleFonts.poppins(color: c, fontSize: s, fontWeight: f);
}
TextStyle appStyleHeight(Color c, double s, FontWeight f, double h) {
  return GoogleFonts.poppins(color: c, fontSize: s, fontWeight: f, height: h);
}
