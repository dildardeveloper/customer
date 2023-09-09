import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../colors/colors.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key? key,
    this.buttonColor = blueColor,
    this.textColor = whiteColor,
    required this.title,
    required this.onPress,
    required this.width,
    required this.height,
    this.loading = false,
    this.borderRadius = 5.0,
  }) : super(key: key);
  final bool loading;
  final String title;
  final double height, width;
  final VoidCallback onPress;
  final Color textColor, buttonColor;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.all(0), // Adjust padding as needed
      ),
      child: Container(
        height: height,
        width: width,
        child: loading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Color(0xffFFFFFF),
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none,
                    fontSize: 16,
                    fontFamily: GoogleFonts.lato().fontFamily,
                  ),
                ),
              ),
      ),
    );
  }
}
