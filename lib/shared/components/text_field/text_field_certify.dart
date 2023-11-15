import 'package:certify/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TextFieldCertify extends StatelessWidget {
  const TextFieldCertify(this.labelText, this.hintText, this.controller, this.keyboardType,
      {super.key, this.obscureText = false, this.secondaryColor = false});

  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final bool secondaryColor;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        style: TextStyle(
          color: secondaryColor ? AppColors.fontSecondary : AppColors.fontPrimary,
        ),
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: secondaryColor ? AppColors.backgroundPrimary : AppColors.backgroundSecondary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: secondaryColor ? AppColors.backgroundPrimary : AppColors.backgroundSecondary, width: 2.5),
          ),
          labelStyle: TextStyle(
            color: secondaryColor ? AppColors.fontSecondary : AppColors.fontPrimary,
          ),
          hintStyle: TextStyle(color: secondaryColor ? AppColors.fontSecondary : AppColors.fontPrimary),
          border: const OutlineInputBorder(),
          hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }
}
