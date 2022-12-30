import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final Color color;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  const TextWidget(
      {super.key,
      required this.text,
      required this.fontSize,
      this.color = Colors.black,
      this.fontWeight = FontWeight.w600});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.urbanist(
            fontSize: fontSize, fontWeight: fontWeight, color: color));
  }
}
