import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../colors/colors.dart';

class Utils{
  static toastMessage(String message){
    Fluttertoast.showToast(
      msg: message ,
      backgroundColor: redColor ,
      textColor: whiteColor,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }
  static toastMessageCenter(String message){
    Fluttertoast.showToast(
      msg: message ,
      backgroundColor: redColor ,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      textColor: whiteColor,
    );
  }
  static snackBar(String title, String message){
    Get.snackbar(
      title,
      message ,
      backgroundColor: whiteColor
    );
  }
}
Future<OkCancelResult> errorOverlay(BuildContext context, {String? title, String? message, String? okLabel}) async {
  return await showOkAlertDialog(context: context, title: title, message: message, okLabel: okLabel);
}

Future<dynamic> loadingOverlay(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
          backgroundColor: transparentColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: CircleAvatar(
              radius: 60, backgroundColor: whiteColor, child: Lottie.asset('assets/icons/loading.json'))));
}

Future<dynamic> loadingStatusDialog(BuildContext context, {required String title}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
          backgroundColor: whiteColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const LoadingWidget(height: 70),
            Text( title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            const SizedBox(width: 8)
          ])));
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, this.height}) : super(key: key);
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/loading.json', height: height);
  }
}
