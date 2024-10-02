import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextField extends StatefulWidget {
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isObscure ? isVisible : false,
      maxLines: widget.maxLines ?? 1,
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: widget.iconPath.isEmpty
              ? null
              : SvgPicture.asset(
                  widget.iconPath,
                  height: 14,
                  width: 14,
                ),
        ),
        suffixIcon: widget.isPassword
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: SvgPicture.asset(
                    widget.prefixPath,
                    height: 14,
                    width: 14,
                  ),
                ),
              )
            : null,
        hintText: widget.hintText,
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
