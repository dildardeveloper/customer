import 'package:customer/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../controllers/customer_profile_controller/customer_profile_controller.dart';
import '../../resource/colors/colors.dart';
import '../../resource/components/widgets/appbar/app_bar.dart';
import '../../resource/components/widgets/buttons/round_button_widget.dart';
import '../../resource/components/widgets/formtextfield/text_input_field_widget.dart';
import '../../resource/components/widgets/image_picker/image_picker.dart';
import '../signin_view/signin_view.dart';
class CustomerProfile extends StatefulWidget {
  const CustomerProfile({Key? key}) : super(key: key);
  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}
class _CustomerProfileState extends State<CustomerProfile> {
  GlobalKey<FormState> _profileFormKey = GlobalKey<FormState>();

  RxString profileImage=''.obs;
  @override
  Widget build(BuildContext context) {
 final _customerProfileController  =Get.put(CustomerProfileController());
    return GestureDetector(
      onTap: (() {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }),
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: blueColor,
          label: Text('Logout'), onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_){
            return SignInView();
          }));
        },
          icon: Icon(Icons.logout),
        ),
        appBar: CustomAppBar(
          title: ' Customer Profile',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: _profileFormKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
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
                                  final pickedImage = await showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 210,
                                        child:  CustomImagePicker(
                                          onImagePicked: (value) {
                                            if(value!=null){
                                              profileImage.value=value.path;
                                            }
                                            Navigator.pop(context, value); // Return the picked image to the caller
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Icon(
                                  Icons.edit,
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
                    height: 15,
                  ),
                  TextInputFieldWidget(
                    isRequired: false,
                    controller:_customerProfileController.CustomerProfileNameController.value,
                    // hintText: "Enter Full Name",
                    lable: 'Name',
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextInputFieldWidget(
                    isRequired:false,
                    controller: _customerProfileController.CustomerProfileEmailController.value,
                    // hintText: "Enter Full Name",
                    lable: 'Email',
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20,),
                  RoundButton(title: 'Update',width: MediaQuery.of(context).size.width*.5, height: 43,
                    borderRadius:25, onPress: () {
                    if(_profileFormKey.currentState!.validate()){
                      Get.toNamed(RouteName.signin_view);
                    }else {
                      print("some thing wrong");
                    }
                      // Get.toNamed(RouteName.signup_view);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) =>  SignInView()),
                      // );
                  },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
