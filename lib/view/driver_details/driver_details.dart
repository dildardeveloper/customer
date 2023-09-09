import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/driver_detail_controller/driver_detail_controller.dart';
import '../../resource/components/widgets/appbar/app_bar.dart';
import '../../resource/components/widgets/buttons/round_button_widget.dart';
import '../../resource/components/widgets/formtextfield/text_input_field_widget.dart';
class DriverDetails extends StatefulWidget {
  final String res;
  DriverDetails({Key? key, required this.res}) : super(key: key);
  @override
  State<DriverDetails> createState() => _DriverDetailsState();
}
class _DriverDetailsState extends State<DriverDetails> {
  @override
  Widget build(BuildContext context) {
    final _DriverDetailController = Get.put(DriverDetailController());
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Driver Details',
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                      radius: 50, backgroundImage: AssetImage("assets/dp.jpg")),
                  SizedBox(
                    height: 8,
                  ),
                  TextInputFieldWidget(
                    controller:
                        _DriverDetailController.DriverNameController.value,
                    lable: 'Full Name',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextInputFieldWidget(
                    controller:
                        _DriverDetailController.DriverPhoneController.value,
                    lable: 'phone',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextInputFieldWidget(
                    controller:
                        _DriverDetailController.DriverRegistrationID.value,
                    lable: 'Registration ID',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundButton(
                        title: 'Start Trip',
                        onPress: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SignupView()),
                          // );
                        },
                        width: MediaQuery.of(context).size.width * .3,
                        height: 43,
                        borderRadius: 5,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RoundButton(
                        title: 'End Trip',
                        onPress: () {

                        },
                        width: MediaQuery.of(context).size.width * .3,
                        height: 43,
                        borderRadius: 5,
                      ),
                    ],
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
