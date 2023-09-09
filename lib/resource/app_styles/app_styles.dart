
import 'package:flutter/material.dart';
class AppTextStyles extends StatelessWidget {
  AppTextStyles({Key? key, required this.text, this.textAlign, this.textDirection, this.textOverflow, this.maxLine, this.color, this.fontWeight, this.fontSize, this.letterSpacing, this.wordSpacing, this.textDecoration, this.fontFamily}) : super(key: key);
   final String text;
   final TextAlign? textAlign;
   final TextDirection? textDirection;
   final TextOverflow? textOverflow;
   final int? maxLine;
   final Color? color;
   final FontWeight? fontWeight;
   final double? fontSize, letterSpacing, wordSpacing;
   final TextDecoration? textDecoration;
   final String? fontFamily;
  @override
  Widget build(BuildContext context) {
    return Text(text,
      textAlign: textAlign,
      textDirection: textDirection,
      overflow: textOverflow,
      maxLines: maxLine,
      style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      decoration: textDecoration
    ),);
  }
}
