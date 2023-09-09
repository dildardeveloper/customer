import 'package:flutter/material.dart';
import '../../resource/colors/colors.dart';
import '../../resource/components/widgets/appbar/app_bar.dart';
import '../../resource/components/widgets/trip_info_card/trip_info_card.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({Key? key}) : super(key: key);

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: 'Trips',),
   body: SafeArea(
     child: SingleChildScrollView(
       child:  TripInfoWidget(
         height: 150,
         width: MediaQuery.of(context).size.width*0.9, color: lightGrayColor.withOpacity(0.5), image: 'assets/car.png', title: 'Dildar', title1: 'Avg.speed', title2: 'Distance',number: 300,

       ),
     ),
   ),
    );
  }
}
