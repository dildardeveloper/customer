import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../controllers/trip_track_controller/trip_track_controller.dart';
import '../../model/my_trip_track/my_trip.dart';
class TripTrackScreen extends StatelessWidget {
  final MyTrip trip;
  DateFormat _format = DateFormat.yMd().add_jm();
  TripTrackScreen({Key? key, required this.trip}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Playback"),
        ),
        body: SafeArea(
          child: GetBuilder<TripTrackController>(
              init: TripTrackController(myTrip: trip),
              builder: (controller) {
                return controller.position == null
                //  ||
                //         controller.deviceController == null
                    ? Center(
                  child: CircularProgressIndicator(
                    color: Get.theme.primaryColor,
                  ),
                )
                    : StreamBuilder(
                    stream: Stream.periodic(Duration(seconds: 1), (e) {
                      if (controller.played &&
                          controller.counter <
                              controller.positions.length - 1) {
                        controller.counter++;
                        controller.slidervalue++;
                        controller.update();
                        controller.playUsingSlider(controller.counter);
                      }
                    }),
                    builder: (context, snapshot) {
                      return Container(
                          height: 1.sh,
                          width: 1.sw,
                          child: Stack(children: [
                            GoogleMap(
                              polylines: controller.polyline == null
                                  ? {}
                                  : {controller.polyline!},
                              onTap: (p) {
                                controller.customInfoWindowController
                                    .hideInfoWindow!();
                              },
                              trafficEnabled: controller.trafficMode,
                              mapType: controller.satelliteMode
                                  ? MapType.satellite
                                  : MapType.normal,
                              onMapCreated: (mapcontroller) {
                                controller.customInfoWindowController
                                    .googleMapController = mapcontroller;
                                controller.update();
                              },
                              markers: controller.liveMarker,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  controller.position!.latitude,
                                  controller.position!.longitude,
                                ),
                                zoom: 13,
                              ),
                            ),
                            Positioned(
                              width: 1.sw,
                              height: .22.sh,
                              bottom: 0,
                              child: Container(
                                padding: EdgeInsets.only(top: 30.sp),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icons/speedometer.png",
                                              height: 30.sp,
                                            ),
                                            const Text(
                                              "Speed",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              "${(controller.positions[controller.counter].speed * 1.852).toStringAsFixed(2)} km/h",
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icons/distance.png",
                                              height: 30.sp,
                                            ),
                                            const Text(
                                              "Distance",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              "${(controller.positions[controller.counter].attributes['totalDistance'] / 1000).toStringAsFixed(2)} km",
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icons/time.png",
                                              height: 30.sp,
                                            ),
                                            const Text(
                                              "Time",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              _format.format(
                                                DateTime.parse(controller
                                                    .positions[
                                                controller
                                                    .counter]
                                                    .serverTime)
                                                    .add(
                                                  Duration(hours: 5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 1.sw,
                                      color: Colors.black45,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: .8.sw,
                                            child: Slider(
                                              thumbColor:
                                              Get.theme.primaryColor,
                                              activeColor:
                                              Get.theme.primaryColor,
                                              max: controller.positions ==
                                                  null
                                                  ? 0
                                                  : (controller.positions
                                                  .length -
                                                  1)
                                                  .toDouble(),
                                              min: 0,
                                              value: controller.slidervalue,
                                              onChanged: (v) {
                                                controller.slidervalue = v;
                                                controller.playUsingSlider(
                                                    v.toInt());
                                              },
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              controller.played
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              color: Colors.white70,
                                            ),
                                            onPressed: () {
                                              controller.played =
                                              !controller.played;
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                right: 0,
                                top: .07.sh,
                                child: Container(
                                  height: .21.sh,
                                  width: .13.sw,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                        15,
                                      ),
                                      bottomLeft: Radius.circular(
                                        15,
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.all(12.sp),
                                        onPressed: () {
                                          controller
                                              .customInfoWindowController
                                              .googleMapController!
                                              .animateCamera(
                                            CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                target: LatLng(
                                                  controller
                                                      .position!.latitude,
                                                  controller
                                                      .position!.longitude,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Image.asset(
                                          "assets/icons/centermap.png",
                                        ),
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.all(8.sp),
                                        onPressed: () {
                                          controller.satelliteMode =
                                          !controller.satelliteMode;
                                          controller.update();
                                        },
                                        icon: Image.asset(
                                          "assets/icons/currentlocation.png",
                                          color: controller.satelliteMode
                                              ? Get.theme.primaryColor
                                              : Colors.blueGrey,
                                        ),
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.all(8.sp),
                                        onPressed: () {
                                          controller.trafficMode =
                                          !controller.trafficMode;
                                          controller.update();
                                        },
                                        icon: Image.asset(
                                          "assets/icons/traffic.png",
                                          color: controller.trafficMode
                                              ? Get.theme.primaryColor
                                              : Colors.blueGrey,
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                          ]));
                    });
              }),
        ),
      );
    });
  }
}
