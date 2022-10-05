import 'package:flutter/material.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/res/styles.dart';

class InputText extends StatelessWidget {
  final String placeholder;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool secureTextEntry;
  final double height;

  const InputText({
    Key? key,
    required this.placeholder,
    this.controller,
    this.keyboardType = TextInputType.name,
    this.secureTextEntry = false,
    this.height = 52,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(
          color: AppColors.borderInput.withOpacity(0.6),
          width: 0.4,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        obscureText: secureTextEntry,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          border: InputBorder.none,
          hintText: placeholder,
          hintStyle: AppStyles.textBody2PublicSans
              .copyWith(color: const Color(0xFFc4c5c7)),
        ),
      ),
    );
  }
}
