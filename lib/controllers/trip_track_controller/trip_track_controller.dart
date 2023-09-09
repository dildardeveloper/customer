import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marker_icon/marker_icon.dart';

import '../../configs/assets_configs.dart';
import '../../model/my_trip_track/my_trip.dart';
import '../../model/position/position.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import '../../services/vehicle_services.dart';
import '../devices_controller/devices_controller.dart';

class TripTrackController extends GetxController {
  Position? position;
  bool trafficMode = false;
  bool satelliteMode = false;
  MyTrip? myTrip;
  Polyline? polyline;
  CustomInfoWindowController customInfoWindowController =
  CustomInfoWindowController();
  BitmapDescriptor icon = BitmapDescriptor.defaultMarker;
  List<Position> positions = [];
  int counter = 0;
  double slidervalue = 0;
  bool played = true;
  Set<Marker> liveMarker = { };
  List<LatLng> points = [ ];
  List<LatLng> pointsforplay = [];
  TripTrackController({required this.myTrip});

  @override
  void onInit() async {
    final DevicesController controller = Get.find<DevicesController>();

    final device = controller.devices![controller.index];
    await VehicleServices.getPositionWithTime(
        deviceId: device.id.toString(),
        from: myTrip!.startTime,
        to: myTrip!.endTime)
        .then((value) {
      position = value.first;
      positions = value.where((element) => element.valid).toList();
      for (int i = 0; i < value.length; i++) {
        if (value[i].valid) {
          pointsforplay.add(
            LatLng(
              value[i].latitude,
              value[i].longitude,
            ),
          );
        }
      }

      update();
    });
    icon = await MarkerIcon.pictureAsset(
        height: 70,
        width: 70,
        assetPath: device.category == 'car'
            ? AssetsConfigs.liveCar
            : device.category == 'bike' ||
            device.category == 'scooter' ||
            device.category == 'motorcycle'
            ? AssetsConfigs.liveBike
            : device.category == 'bus'
            ? AssetsConfigs.liveBus
            : device.category == 'truck'
            ? AssetsConfigs.liveTruck
            : AssetsConfigs.livePickup);
    polyline = Polyline(
        polylineId: PolylineId(device.id.toString()),
        points: pointsforplay,
        width: 3);
    super.onInit();
  }

  void playUsingSlider(int pos) async {
    counter = pos;
    liveMarker = {
      Marker(
        markerId: MarkerId(
          'vehicleMarker',
        ),
        position: pointsforplay[counter],
        rotation: positions[counter].course,
        icon: icon,
      )
    };
    moveCamera(positions[pos]);

    update();
  }

  void moveCamera(Position pos) async {
    CameraPosition cPosition = CameraPosition(
      target: LatLng(pos.latitude, pos.longitude),
      zoom: 13,
    );

    final GoogleMapController controller =
    customInfoWindowController.googleMapController!;
    controller.moveCamera(CameraUpdate.newCameraPosition(cPosition));
  }

  // Future<void> _showProgress(bool status) {
  //   if (status) {
  //     return showDialog<void>(
  //       context: context,
  //       barrierDismissible: true, // user must tap button!
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           content: new Row(
  //             children: [
  //               CircularProgressIndicator(),
  //               Container(
  //                   margin: EdgeInsets.only(left: 5), child: Text('Loading')),
  //             ],
  //           ),
  //         );
  //       },
  //     );
  //   } else {
  //     Navigator.pop(context);
  //   }
  // }
  getIcons() async {
    final Uint8List markerIcon =
    await getBytesFromAsset('assets/images/car.png', 80);

    icon = BitmapDescriptor.fromBytes(markerIcon);
  }

  getIconsOff() async {
    final Uint8List markerIcon =
    await getBytesFromAsset('assets/images/carred.png', 80);

    icon = BitmapDescriptor.fromBytes(markerIcon);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
