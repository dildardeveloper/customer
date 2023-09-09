import 'package:customer/controllers/auth/auth_controller.dart';
import 'package:customer/resource/app_styles/app_styles.dart';
import 'package:customer/resource/colors/colors.dart';
import 'package:customer/view/signup_view/signup_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../resource/components/widgets/buttons/round_button_widget.dart';
import '../../resource/components/widgets/formtextfield/text_input_field_widget.dart';
import '../../routes/routes_name.dart';
import '../bottom_navigation_bar/bottom_navigation_bar.dart';
class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);
  @override
  State<SignInView> createState() => _SignInViewState();
}
class _SignInViewState extends State<SignInView> {
  GlobalKey<FormState> _signinFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _authController = Get.put(AuthController());
    return GestureDetector(
      onTap: (() {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30),
                child: Form(
                  key: _signinFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 120,
                      ),
                      Image(
                        image: AssetImage(
                          'assets/logopaynamy.jpg',
                        ),
                        width: 150,
                        height: 110,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextInputFieldWidget(

                          isEmail: true,
                          textInputType: TextInputType.emailAddress,
                          lable: 'Email *',
                          controller:
                              _authController.SignInEmailController.value),
                      SizedBox(
                        height: 20,
                      ),
                      TextInputFieldWidget(

                        digitsOnly: true,
                        textInputType: TextInputType.name,
                        lable: 'Password *',
                        controller:
                            _authController.SignInPasswordController.value,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                     Obx((){
                       return  _authController.loading.value?CircularProgressIndicator():RoundButton(
                         title: 'Login',
                         onPress: () {
                           if (_signinFormKey.currentState!.validate()) {
                             _authController.login(context);
                             //Get.toNamed(RouteName.signup_view);
                             // Navigator.push(
                             //   context,
                             //   MaterialPageRoute(
                             //       builder: (context) => BottomNavbar()),
                             // );
                           } else {
                             print("Some thing wrong");
                           }
                         },
                         width: MediaQuery.of(context).size.width * .5,
                         height: 43,
                         borderRadius: 25,
                       );
                     }),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Don’t have an account |',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'lato',
                                  ),
                                ),
                                TextSpan(
                                  text: ' Signup',
                                  style: TextStyle(
                                    color: blueColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'lato',
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => {
                                    Get.toNamed(RouteName.signup_view),
                                        },
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
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
