import 'dart:developer';

import 'package:customer/resource/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import '../../resource/components/widgets/appbar/app_bar.dart';
import '../../resource/components/widgets/buttons/round_button_widget.dart';
import '../../routes/routes_name.dart';
import '../driver_details/driver_details.dart';
class ScannerView extends StatefulWidget {
  const ScannerView({Key? key}) : super(key: key);
  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  @override
  Widget build(BuildContext context) {
    String result = '';

    return  Scaffold(
      backgroundColor: Colors.white,
      appBar:CustomAppBar(title: 'Scanner',) ,
      body: SafeArea(child: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                 Container(
                     height: MediaQuery.of(context).size.height*0.9,
                     child: Center(child:  ElevatedButton(
                       onPressed: () async {
                         var res = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", false, ScanMode.QR);
                         if(res != '-1'){
                            Get.to(DriverDetails(res: res));
                           // Navigator.push(
                           //   context,
                           //   MaterialPageRoute(builder: (context) =>  DriverDetails(
                           //       res:res,
                           //   )),
                           // );
                         }  else{
                           print("nulll");
                         }
                         //log('barcode result: $res');
                       },
                       child:  Text('Open Scanner'),
                     ),)),

              //Text('Barcode Result: $result'),
            ],
          ),
        ),
      )),
    );
  }
}
