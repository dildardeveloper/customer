import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../colors/colors.dart';

class TextInputFieldWidget extends StatelessWidget {
  TextInputFieldWidget(
      {Key? key,
        this.lable,
        this.suffixIcon,
        this.prefixIcon,
        this.cursorsColor = blackColor,
        this.isRequired = true,
        this.autoFillHints,
        this.capitalization,
        this.controller,
        this.formatter,
        this.isReadOnly,
        this.maxLines,
        this.obscure,
        this.onChange,
        this.ontap,
        this.textInputType,
        this.validators,
        this.initialValue,
        this.hintText,
        this.autovalidateMode,
        this.maxLength,
        this.isDisabled,
        this.prefixText,
        this.secondPrefixText,
        this.onEditingComplete,
        this.onFieldSubmitted,
        this.onSaved,
        this.digitsOnly = false,
        this.isEmail = false,
        this.enable,
        this.isPhoneNo = false,
        this.width = double.infinity,
        this.height = 50.0,  this.isPasswordNo=false,
      })
      : super(key: key);
  String? lable;
  final Widget? suffixIcon, prefixIcon;
  final Iterable<String>? autoFillHints;
  final TextCapitalization? capitalization;
  final List<TextInputFormatter>? formatter;
  final bool? obscure, isReadOnly, isDisabled;
  final bool isRequired, isPhoneNo, isEmail, digitsOnly,isPasswordNo;
  final String? Function(String?)? validators;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Color cursorsColor;
  final int? maxLines;
  final String? hintText, initialValue, prefixText, secondPrefixText;
  final AutovalidateMode? autovalidateMode;
  final int? maxLength;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final Function()? ontap, onEditingComplete;
  final bool? enable;
  final RegExp phoneRegex = RegExp(r'^\+?\d{11}$');
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    TextStyle contentStyle = TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.normal,
    );
    return TextFormField(
      initialValue: initialValue,
      autofillHints: autoFillHints,
      textCapitalization: capitalization ?? TextCapitalization.none,
      inputFormatters: formatter,
      obscureText: obscure ?? false,
      readOnly: isReadOnly ?? false,
      validator: (value) {
        if(isRequired) {
          if(value == null || value.isEmpty ){
            return 'Field Required';
          }
          if (digitsOnly) {
            final isDigitsOnly = int.tryParse(value);
            return isDigitsOnly == null ? 'Digits only' : null;
          } else if (isEmail) {
            if (!value.contains("@")) {
              return "Invalid email";
            }
          } else if (isPhoneNo) {
            if (!phoneRegex.hasMatch(value)) {
              return "Invalid Phone Number";
            }
          }
          else if (isPasswordNo) {
            // Add your password validation logic here
            if (value.length < 8) {
              return "Password must be at least 8 characters";
            }
            // Add more conditions as needed
          }
        }
        return null;
      },
      enabled: enable,
      controller: controller,
      cursorColor: cursorsColor,
      textAlign: TextAlign.start,
      onChanged: onChange,
      maxLines: maxLines,
      onTap: ontap,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      maxLength: maxLength,
      keyboardType: textInputType,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
      style: contentStyle,
      decoration: InputDecoration(

        contentPadding: EdgeInsets.only(right: 20),
        focusColor: Colors.blue,
        //floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: hintText,
        labelText: lable,

        fillColor:Colors.white,
        border: InputBorder.none,
        //hintStyle: const TextStyle(color: AppColor.greyColor),
        errorStyle: const TextStyle(color: Colors.red),
        errorBorder: outlineInputBorder,
        labelStyle:  TextStyle(color:primary_dark),

        focusedErrorBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputActiveBorderBlue,
        prefixIconConstraints: const BoxConstraints(),
        counterText: '',
        prefixText: prefixText,
        prefixStyle: contentStyle,
        prefixIcon: lable != null
            ? Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 5.0),
          child: prefixIcon,
        )
            : null,
        suffixIcon: suffixIcon,

      ),

    );
  }
}
final OutlineInputBorder outlineInputActiveBorderBlue = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide:   BorderSide(color: blueColor,width: 2), // Green border color
);
final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: gryColor));
UnderlineInputBorder underlineErrorInputBorder =
UnderlineInputBorder(borderSide: BorderSide(color: gryColor, width: 1));