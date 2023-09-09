import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../colors/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color color;
  final List<Widget> actions;
  final bool automaticallyImplyLeading;

   CustomAppBar({required this.title, this.actions = const [],   this.color = primary_dark,this.automaticallyImplyLeading = false});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      // leading:IconButton(onPressed: (){
      //
      //   Navigator.pop(context);
      // }, icon: Icon(Icons.arrow_back_ios,size: 20,color: blackColor,)
      //
      //
      // ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: whiteColor),
      backgroundColor: color,
      elevation: 1,
      title: Text(title,style:  TextStyle(
        color: Color(0xffFFFFFF),
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.none,
        fontSize: 20,
        fontFamily: GoogleFonts.lato().fontFamily,
      ),),
      actions: actions,
    );
  }
  @override
  Size get preferredSize => AppBar().preferredSize;

}
