import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app_styles/app_styles.dart';
import '../../../colors/colors.dart';
class CustomImagePicker extends StatelessWidget {
  final ValueChanged<XFile> onImagePicked;
  const CustomImagePicker({required this.onImagePicked});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20,),
        AppTextStyles(text: 'Select Image From',color: blackColor, fontSize: 20, fontWeight: FontWeight.w600,),
        SizedBox(height: 30,),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 80,),
            InkWell(
              onTap: () async {
                final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  onImagePicked(pickedImage);
                }
              },
              child: Image.asset("assets/gallery.png",
                width: 60,
              ),
            ),
            InkWell(
              onTap: () async {
                final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
                if (pickedImage != null) {
                  onImagePicked(pickedImage);
                }
              },
              child: Image.asset("assets/camera.png",width: 200,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

