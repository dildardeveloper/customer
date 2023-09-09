import 'package:flutter/material.dart';
import '../../resource/colors/colors.dart';
import '../customer_profile/customer_profile.dart';
import '../map/map.dart';
import '../scanner_view/scanner_view.dart';
import '../trips/trips.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);
  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}
class _BottomNavbarState extends State<BottomNavbar> {
  int _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    var pageIndex = [
      MapScreen(),
      ScannerView(),
      TripsScreen(),
      CustomerProfile(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: primary_dark,
        unselectedItemColor: Color(0xff3B3A43),
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map,
                  color: _currentIndex == 0 ? Color(0xff000051) : blackColor,
                ),
                Text(
                  'Map',
                  style: TextStyle(
                    color: _currentIndex == 0
                        ? Color(0xff000051)
                        : blackColor,

                  ),
                ),
              ],
            ),
            label: '',
          ),

          BottomNavigationBarItem(
            icon: Column(
              children: [
               Icon(Icons.scanner_outlined,color: _currentIndex == 1
                ? Color(0xff000051)
                : blackColor,),
                Text(
                  'Scanner',
                  style: TextStyle(
                    color: _currentIndex == 1
                        ? Color(0xff000051)
                        : blackColor,),
                ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Center(
              child: Column(
                children: [
                  Image.asset('assets/trips.png',width: 20,height: 20, color:
                  _currentIndex == 2 ? Color(0xff000051) : blackColor,),
                  Text(
                    'Trips',
                    style: TextStyle(
                      color:
                      _currentIndex == 2 ? Color(0xff000051) : blackColor,
                    ),
                  ),
                ],
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Icon(
                  Icons.person,
                  color: _currentIndex == 3 ? Color(0xff000051) : blackColor,
                ),
                Text(
                  'Profile',
                  style: TextStyle(
                    color: _currentIndex == 3
                        ? Color(0xff000051)
                        : blackColor,)
                  ,
                ),
              ],
            ),
            label: '',
          ),
        ],
      ),
      body: pageIndex[_currentIndex],
    );
  }
}
