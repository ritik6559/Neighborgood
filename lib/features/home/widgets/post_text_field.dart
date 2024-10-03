import 'package:flutter/material.dart';

class PostTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String iconPath;
  final VoidCallback? onSubmitted;
  const PostTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.iconPath, required this.onSubmitted,});

  @override
  Widget build(BuildContext context) {


    

    return SizedBox(
      height: 40,
      child: TextField(
        onSubmitted: (value) => onSubmitted?.call(),
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.5),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 10,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(iconPath),
                ),
              ),
            ),
          ),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
