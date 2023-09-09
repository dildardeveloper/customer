import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/my_device/my_device.dart';
import '../../services/vehicle_services.dart';

class DevicesController extends GetxController {
  List<MyDevice>? devices;
  int index = 0;
  @override
  void onInit() async {
    await SharedPreferences.getInstance().then((prefs) {
      index = prefs.getInt("currentIndex") ?? 0;
      update();
    });
    await VehicleServices.getAllVehicles().then((value) {
      devices = value;
      update();
    });
    super.onInit();
  }

  Future<void> changeIndex(int ind, context) async {
    Get.dialog(
      Center(
        child: CupertinoActivityIndicator(),
      ),
      barrierDismissible: false,
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("currentIndex", ind);
    index = ind;
    // PositionController positionController = Get.put(PositionController());
    // positionController.onDelete();

    Get.reloadAll(
      force: true,
    );
   // SplashController splashController = Get.put(SplashController());
  }
}
