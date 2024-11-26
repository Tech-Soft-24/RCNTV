


import 'package:flutter/material.dart';
import 'package:livetv2024/app/constant/text.dart';

import '../constant/color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key, required this.hintText, this.border, this.obscureText, required this.textController
  });

  final String? hintText;
  final Color? border;
  final bool? obscureText;
  final TextEditingController? textController;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      style: const TextStyle(color: AppColor.black,fontSize: 18,fontWeight: FontWeight.w500),
      maxLines: 1,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyle.grey18w500,
        filled: true,
        fillColor: AppColor.white,

        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: border ?? AppColor.purple, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:  BorderSide(color: border ?? AppColor.purple, width: 1.0),
        ),
      ),
    );
  }
}