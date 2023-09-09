import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../model/login_model.dart';
import '../../repository/login_repository/login_repository.dart';
import '../../resource/Utils/utils.dart';
import '../../routes/routes_name.dart';
import '../user_preference/user_prefrence_view_model.dart';
class AuthController extends GetxController{
  ///Signup screen controller
  final  SignupNameController = TextEditingController().obs;
  final  SignupEmailController = TextEditingController().obs;
  final  SignupPasswordController = TextEditingController().obs;
  final  SignupPhoneController = TextEditingController().obs;
  final  SignupAddressController = TextEditingController().obs;
  ///Signin Screen Controller
  final SignInEmailController = TextEditingController().obs;
  final SignInPasswordController=TextEditingController().obs;
  RxBool loading=false.obs;
  final _loginApi = LoginRepository();
  UserPreference userPreference = UserPreference();
  ///LoginApi
  Future<void> login(BuildContext context) async {
    try {
      loadingStatusDialog(context, title: 'Signingin');
      Map<String, dynamic> data = {
        "email": SignInEmailController.value.text,
        "password": SignInPasswordController.value.text,
      };
      _loginApi.loginApi(data).then((value) {
        if (value['status_code'] == 200) {
          Get.back();
          Data userData = Data(
            bearerToken: value['data']['bearer_token'],
            user: value['data']['user'],
          );
          LoginModel userModel = LoginModel(
            statusCode: value['status_code'],
            message: value['message'],
            error: value['error'],
            data: userData,
            isLogin: true,
          );
          userPreference.saveUser(userModel).then((value) {
            // releasing resources because we are not going to use this
            Get.delete<AuthController>();
            SignInEmailController.value.clear();
            SignInPasswordController.value.clear();
            Get.offAllNamed(RouteName.bottom_navigation_bar)!.then((value){});
            Utils.snackBar('Login', 'Login successfully');
          }).onError((error, stackTrace) {
            Utils.snackBar('Error', error.toString());
          });
        }
        else {
          Utils.snackBar('Login', 'Unknown error occurred');
          Get.offAllNamed(RouteName.signin_view);  // Go back to SignInView
        }
      }).onError((error, stackTrace) {
        Get.back();  // Close the dialog in case of error
        Utils.snackBar('Error', error.toString());
        print("Error while LoginIn ${error.toString()}");
        Get.offAllNamed(RouteName.signin_view);  // Go back to SignInView in case of error
      });
    } catch (e) {
      Get.back();
      errorOverlay(context, title: 'Signin Failed', message: e.toString(),okLabel: 'ok');
      log(e.toString());
    }
  }
}