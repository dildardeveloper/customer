import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:intl/intl.dart';

import '../../model/my_trip_track/my_trip.dart';
import '../../services/vehicle_services.dart';
import '../devices_controller/devices_controller.dart';

class TripsPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  List<MyTrip>? trips;
  List<MyTrip>? allTrips;
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  DevicesController deviceController =
  Get.put<DevicesController>(DevicesController());
  @override
  void onInit() async {
    tabController = TabController(length: 3, vsync: this);
    allTrips = await VehicleServices.getTrips(
      DateTime.now().subtract(Duration(days: 30)).toIso8601String(),
      DateTime.now().toIso8601String(),
      deviceId: deviceController.devices![deviceController.index].id.toString() ?? "2",
    );

    updateTripsOnDisplay();
    super.onInit();
  }

  updateTripsOnDisplay() {
    trips = tabController!.index == 0
        ? allTrips!
        .where((element) =>
    dateFormat.format(DateTime.parse(element.startTime)) ==
        dateFormat.format(DateTime.now()))
        .toList()
        : tabController!.index == 1
        ? allTrips!
        .where((element) =>
    DateTime.parse(element.startTime)
        .difference(DateTime.now())
        .inDays <=
        7)
        .toList()
        : allTrips;
    trips!.sort(((a, b) {
      return DateTime.parse(b.startTime).compareTo(DateTime.parse(a.startTime));
    }));
    update();
  }
}
