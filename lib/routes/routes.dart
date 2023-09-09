import 'package:customer/routes/routes_name.dart';

import 'package:get/get.dart';

import '../view/bottom_navigation_bar/bottom_navigation_bar.dart';
import '../view/signin_view/signin_view.dart';
import '../view/signup_view/signup_view.dart';
class AppRoutes{
  static appRoutes() =>[
    GetPage(name: RouteName.signin_view, page: ()=> SignInView(),
      transitionDuration:  Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(name: RouteName.signup_view, page: ()=>SignupView(),
      transition: Transition.leftToRightWithFade,
      transitionDuration:  Duration(milliseconds: 250),
    ),
    GetPage(
      name: RouteName.bottom_navigation_bar,
      page: () => BottomNavbar(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    // GetPage(name: RouteName.add_device_view, page: ()=>AddDeviceView(),
    //   transition: Transition.leftToRightWithFade,
    //   transitionDuration: const Duration(milliseconds: 250),
    // ),
    // GetPage(name: RouteName.add_deriver_view, page: ()=>AddDriverView(),
    //   transition: Transition.leftToRightWithFade,
    //   transitionDuration: const Duration(milliseconds: 250),
    //
    // ),
    // GetPage(name: RouteName.add_vehicle_view, page: ()=>AddVehicleView(),
    //   transition: Transition.leftToRightWithFade,
    //   transitionDuration: const Duration(milliseconds: 250),
    //
    // ),
    // GetPage(name: RouteName.admin_profile, page: ()=>AdminProfile(),
    //   transition: Transition.leftToRightWithFade,
    //   transitionDuration: const Duration(milliseconds: 250),
    //
    // ),
    // GetPage(name: RouteName.device_view, page: ()=>DeviceView(),
    //   transition: Transition.leftToRightWithFade,
    //   transitionDuration: const Duration(milliseconds: 250),
    //
    // ),
    // GetPage(name: RouteName.driver_view, page: ()=>Driverview(),
    //   transition: Transition.leftToRightWithFade,
    //   transitionDuration: const Duration(milliseconds: 250),
    // ),
    // GetPage(name: RouteName.edit_view, page: ()=>EditDriver(),
    //   transition: Transition.leftToRightWithFade,
    //   transitionDuration: const Duration(milliseconds: 250),
    // ),
    // GetPage(name: RouteName.map, page: ()=>MapScreen(),
    //   transition: Transition.leftToRightWithFade,
    //   transitionDuration: const Duration(milliseconds: 250),
    // ),
  ];
}