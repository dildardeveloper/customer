import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_styles/app_styles.dart';
import '../../../colors/colors.dart';

class TripInfoWidget extends StatefulWidget {
  final String image;
  final String? text;
  final int? number;
  final double? height;
  final double? width;
  final Color? color;
  final String? date;
  final String title;
  final String title1;
  final String title2;
  TripInfoWidget({
    required this.image,
    //required this.text,
    this.height,
    this.width,
     this.color, this.number, this.date, required this.title, this.text, required this.title1, required this.title2,
  });
  @override
  State<TripInfoWidget> createState() => _TripInfoWidgetState();
}
class _TripInfoWidgetState extends State<TripInfoWidget> {
  RxInt _index=0.obs;
  //int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      color: lightGrayColor,
      margin: EdgeInsets.all(20),

      child: Column(
        children: [
          ListTile(
            onTap: (){
            },
            leading:Image(image: AssetImage(widget.image),width: 70,),
            title: Text(widget.title),
            subtitle: Text("1/2/2"),
            trailing: Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Text(widget.title1),
                      SizedBox(
                        height: 5,
                      ),
                      Text('34.67'),
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      Text(widget.title2),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.number.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: blackColor,
          ),
        Obx(() =>Stepper(
          currentStep: _index.value,
          onStepCancel: () {
            if (_index.value > 0) {
                _index.value -= 1;
            }
          },
          onStepTapped: (int index) {
              _index.value = index;
          },
          steps: <Step>[
            Step(
                title: ListTile(title: AppTextStyles(text: 'Show Start Address',fontSize: 15,color: blueColor,fontWeight: FontWeight.w600,), trailing: Text('7.45 PM'),),
                content: Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text('Show Start address'),
                ),
                state: StepState.indexed,
                isActive: true
            ),
            Step(
                title: ListTile(title: AppTextStyles(text: 'Show End Address',fontSize: 15,color: blueColor,fontWeight: FontWeight.w600,), trailing: Text('7.45 PM'),),
                content: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text('Show End address'),
                    )),
                state: StepState.indexed,
                isActive:_index.value==1? true:false
            ),
          ],
          controlsBuilder: (BuildContext context, ControlsDetails controlsDetails ){
            return Container();
          },
        ), ),
          // Display the text
          // Display the number
        ],
      ),
    );
  }
}
// GetBuilder<TripsPageController>(
// init: TripsPageController(),
// builder: (controller) {
// return ScreenUtilInit(builder: (context, _) {
// return Scaffold(
// // key: _key,
// // drawer: MyDrawer(),
// // appBar: AppBar(
// //   actions: [
// //     IconButton(
// //       onPressed: () {
// //         Get.to(() => NotificationsScreen());
// //       },
// //       icon: Icon(
// //         CupertinoIcons.bell,
// //       ),
// //     ),
// //   ],
// //   leadingWidth: .15.sw,
// //   leading: IconButton(
// //     padding: EdgeInsets.all(15.sp),
// //     onPressed: () {
// //       _key.currentState!.openDrawer();
// //     },
// //     icon: Image.asset(
// //       "assets/icons/drawer.png",
// //     ),
// //   ),
// //   title: const Text("Trips"),
// //   bottom: TabBar(
// //     onTap: (index) {
// //       controller.updateTripsOnDisplay();
// //     },
// //     controller: controller.tabController,
// //     indicatorColor: Colors.white,
// //     tabs: [
// //       Padding(
// //         padding: const EdgeInsets.all(12.0),
// //         child: Text("Today"),
// //       ),
// //       Padding(
// //         padding: const EdgeInsets.all(12.0),
// //         child: Text("This Week"),
// //       ),
// //       Padding(
// //         padding: const EdgeInsets.all(12.0),
// //         child: Text("This Month"),
// //       ),
// //     ],
// //   ),
// // ),
// body: Padding(
// padding: EdgeInsets.all(20),
// child: controller.trips == null
// ? Center(
// child: CircularProgressIndicator(
// color: Get.theme.primaryColor),
// )
//     : ListView.builder(
// padding: EdgeInsets.only(bottom: .15.sh),
// itemCount: controller.trips!.length,
// itemBuilder: (context, index) {
// return InkWell(
// onTap: () {
// Get.to(() => TripTrackScreen(
// trip: controller.trips![index],
// ));
// },
// child: Container(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// dateFormat.format(DateTime.parse(
// controller.trips![index].startTime)),
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 17.sp),
// ),
// Container(
// margin: EdgeInsets.symmetric(vertical: 10),
// padding: EdgeInsets.all(10.sp),
// decoration: BoxDecoration(
// color: Colors.grey.shade300,
// borderRadius: BorderRadius.circular(20),
// ),
// child: Column(
// children: [
// Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// SizedBox(
// width: .38.sw,
// child: Row(
// children: [
// Container(
// height: 30.sp,
// child: Image.asset(
// "assets/vehicles/car.png",
// ),
// decoration: BoxDecoration(),
// ),
// SizedBox(
// width: 10.sp,
// ),
// Column(
// crossAxisAlignment:
// CrossAxisAlignment
//     .start,
// children: [
// Text(
// "Trip ${controller.trips!.length - index}",
// style: TextStyle(
// fontSize: 15.sp,
// fontWeight:
// FontWeight.bold,
// ),
// ),
// Text(
// dateFormat.format(DateTime
//     .parse(controller
//     .trips![
// index]
//     .startTime)
//     .add(Duration(
// hours: 5))),
// style: TextStyle(
// color: Colors.grey,
// ),
// )
// ],
// ),
// ],
// ),
// ),
// Expanded(
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment
//     .spaceEvenly,
// children: [
// Column(
// children: [
// const Text(
// "Fuel",
// style: TextStyle(
// color: Colors.grey,
// ),
// ),
// Text(controller
//     .deviceController
//     .devices![controller
//     .deviceController
//     .index]
//     .attributes ==
// null ||
// controller.deviceController.devices![controller.deviceController.index].attributes[
// "mileage"] ==
// null
// ? ""
//     : ((controller.trips![index].distance /
// 1000) /
// double.parse(controller
//     .deviceController
//     .devices![controller
//     .deviceController
//     .index]
//     .attributes["mileage"]))
//     .toStringAsFixed(2))
// ],
// ),
// Column(
// children: [
// Text(
// "Avg. Speed",
// style: TextStyle(
// color: Colors.grey,
// ),
// ),
// Text((controller
//     .trips![index]
//     .averageSpeed *
// 1.852)
//     .toStringAsFixed(2))
// ],
// ),
// Column(
// children: [
// Text(
// "Distance",
// style: TextStyle(
// color: Colors.grey,
// ),
// ),
// Text((controller
//     .trips![index]
//     .distance /
// 1000)
//     .toStringAsFixed(2))
// ],
// ),
// ],
// ),
// )
// ],
// ),
// Divider(),
// Row(
// children: [
// SizedBox(
// child: Column(
// mainAxisAlignment:
// MainAxisAlignment.center,
// children: [
// CircleAvatar(
// backgroundColor:
// Get.theme.primaryColor,
// radius: 8.sp,
// ),
// Image.asset(
// "assets/icons/dottedlinevertical.png"),
// Icon(
// Icons.circle_outlined,
// )
// ],
// ),
// ),
// SizedBox(
// child: Column(
// mainAxisAlignment:
// MainAxisAlignment
//     .spaceBetween,
// children: [
// Container(
// padding:
// EdgeInsets.symmetric(
// horizontal: 10),
// child: Row(
// mainAxisSize:
// MainAxisSize.max,
// mainAxisAlignment:
// MainAxisAlignment
//     .spaceBetween,
// children: [
// TextButton(
// style: TextButton
//     .styleFrom(
// alignment:
// Alignment
//     .centerLeft,
// padding:
// EdgeInsets
//     .zero,
// fixedSize:
// Size(
// .5.sw,
// .05.sh,
// )),
// child: Text(
// "Show Start Address",
// ),
// onPressed: () async {
// List<Placemark> placemark = await GeocodingPlatform
//     .instance
//     .placemarkFromCoordinates(
// controller
//     .trips![
// index]
//     .startLat,
// controller
//     .trips![
// index]
//     .startLon);
// showDialog(
// context:
// context,
// builder:
// (context) {
// return AlertDialog(
// title: const Text(
// "End Address"),
// content: Text(
// "${placemark.first.street}, ${placemark.first.subLocality}, ${placemark.first.locality}"),
// );
// });
// },
// ),
// Text(
// timeFormat.format(DateTime
//     .parse(controller
//     .trips![
// index]
//     .startTime)
//     .add(Duration(
// hours: 5))),
// ),
// ],
// ),
// ),
// Container(
// padding:
// EdgeInsets.symmetric(
// horizontal: 10),
// child: Row(
// mainAxisSize:
// MainAxisSize.max,
// mainAxisAlignment:
// MainAxisAlignment
//     .spaceBetween,
// children: [
// TextButton(
// style: TextButton
//     .styleFrom(
// alignment:
// Alignment
//     .centerLeft,
// padding:
// EdgeInsets
//     .zero,
// fixedSize:
// Size(
// .5.sw,
// .05.sh,
// )),
// child: Text(
// "Show End Address",
// ),
// onPressed: () async {
// List<Placemark> placemark = await GeocodingPlatform
//     .instance
//     .placemarkFromCoordinates(
// controller
//     .trips![
// index]
//     .endLat,
// controller
//     .trips![
// index]
//     .endLon);
// showDialog(
// context:
// context,
// builder:
// (context) {
// return AlertDialog(
// title: Text(
// "End Address"),
// content: Text(
// "${placemark.first.street}, ${placemark.first.subLocality}, ${placemark.first.locality}"),
// );
// });
// },
// ),
// Text(
// timeFormat.format(
// DateTime.parse(
// controller
//     .trips![
// index]
//     .endTime)
//     .add(
// Duration(
// hours: 5,
// ),
// ),
// ),
// ),
// ],
// ),
// ),
// ],
// ),
// ),
// ],
// )
// ],
// ),
// ),
// ],
// ),
// ),
// );
// },
// ),
// ),
// );
// });
// });