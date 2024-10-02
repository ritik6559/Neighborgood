import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color activeColor;
  final double size;
  final double borderRadius;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.size = 24.0,
    this.borderRadius = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: value ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: value ? activeColor : Colors.black,
            width: 2.0,
          ),
        ),
        child: value
            ? Icon(
                Icons.check,
                size: size * 0.8,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
