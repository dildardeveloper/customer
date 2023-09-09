import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../controllers/auth/auth_controller.dart';
import '../../resource/colors/colors.dart';
import '../../resource/components/widgets/appbar/app_bar.dart';
import '../../resource/components/widgets/buttons/round_button_widget.dart';
import '../../resource/components/widgets/formtextfield/text_input_field_widget.dart';
import 'package:get/get.dart';

import '../../resource/components/widgets/image_picker/image_picker.dart';
import '../bottom_navigation_bar/bottom_navigation_bar.dart';
class SignupView extends StatefulWidget {
   SignupView({Key? key}) : super(key: key);
  @override
  State<SignupView> createState() => _SignupViewState();
}
class _SignupViewState extends State<SignupView> {
  GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  RxString selectedValue = ''.obs;
  RxString profileImage = ''.obs;
  @override
  Widget build(BuildContext context) {
    print("object");
    final _authController = Get.put(AuthController());
    return Scaffold(
      key:scaffoldKey,
      appBar: CustomAppBar(
        automaticallyImplyLeading:false,
        title: 'Signup',
      ),
      body: GestureDetector(
        onTap: (() {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        }),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30),
                child: Form(
                  key: _signupFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          height: 110,
                          width: 110,
                          // color: Colors.red,
                          child: Stack(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primary_dark,
                                ),
                                child: Obx(() => CircleAvatar(
                                      backgroundImage: profileImage.value != ""
                                          ? FileImage(File(profileImage.value))
                                          : Image.asset('assets/dp.jpg').image,
                                      radius: 55,
                                    )),
                              ),
                              Positioned(
                                bottom: -5,
                                right: 8,
                                child: Container(
                                  height: 50,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primary_dark,
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      await showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: 210,
                                            child: CustomImagePicker(
                                              onImagePicked: (value) {
                                                if (value != null) {
                                                  // _handleImagePicked(value.path);
                                                  profileImage.value = value.path;
                                                }
                                                Navigator.pop(context,
                                                    value); // Return the picked image to the caller
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: whiteColor,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextInputFieldWidget(

                          lable: 'Full Name ',
                          textInputType: TextInputType.name,
                          controller: _authController.SignupNameController.value),
                      SizedBox(
                        height: 20,
                      ),
                      TextInputFieldWidget(
                        isRequired: false,
                        lable: 'Email ',
                        textInputType: TextInputType.emailAddress,
                        controller: _authController.SignInEmailController.value,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextInputFieldWidget(
                        isRequired: false,
                        lable: 'Password ',
                        textInputType: TextInputType.visiblePassword,
                        controller:
                            _authController.SignInPasswordController.value,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextInputFieldWidget(
                        lable: 'Phone ',
                        isRequired: false,
                        textInputType: TextInputType.phone,
                        controller: _authController.SignupPhoneController.value,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextInputFieldWidget(
                        isRequired: false,
                        lable: 'Address ',
                        controller: _authController.SignupAddressController.value,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(() {
                        return TextInputFieldWidget(
                          isRequired: false,
                          suffixIcon: PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem<String>(
                                  value: 'Bike',
                                  child: Text('Bike'),
                                ),
                                PopupMenuItem<String>(
                                  value: 'Car',
                                  child: Text('Car'),
                                ),
                                // Add more PopupMenuItems as needed
                              ];
                            },
                            onSelected: (String value) {
                              selectedValue.value = value;
                              // Handle dropdown item selection
                              print(
                                  "Selected dropdown item: $selectedValue.value ");
                            },
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                          ),
                          //hintText: "Enter Full Name",
                          lable: selectedValue.value == ''
                              ? 'Vehicle Type'
                              : selectedValue.value,
                        );
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundButton(
                            title: 'Signup', width: MediaQuery.of(context).size.width * .3,
                            height: 43,
                            borderRadius: 5,
                            onPress: () {
                              if (_signupFormKey.currentState!.validate()) {
                                // Form is valid, proceed with signup logic

                                // For example, you can save the form data here

                                // If you want to navigate to another screen after successful signup
                                // you can do so here
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BottomNavbar()),
                                );
                              } else {
                                print("some thing wrong");
                              }
                            },

                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RoundButton(
                            title: 'cancel',
                            onPress: () {},
                            width: MediaQuery.of(context).size.width * .3,
                            height: 43,
                            borderRadius: 5,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
