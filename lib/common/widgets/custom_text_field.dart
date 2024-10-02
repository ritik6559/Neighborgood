import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextField extends StatelessWidget {
  final String iconPath;
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final String prefixPath;
  final bool isObscure;
  final int? maxLines;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.iconPath,
    required this.isPassword,
    this.prefixPath = '',
    this.isObscure = false,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      maxLines: maxLines ?? 1,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: iconPath.isEmpty
              ? null
              : SvgPicture.asset(
                  iconPath,
                  height: 14,
                  width: 14,
                ),
        ),
        suffixIcon: isPassword
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  child: SvgPicture.asset(
                    prefixPath,
                    height: 14,
                    width: 14,
                  ),
                ),
              )
            : null,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: const Color(0xFF000000).withOpacity(0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xFFDDDDDD),
          ),
        ),
      ),
    );
  }
}
