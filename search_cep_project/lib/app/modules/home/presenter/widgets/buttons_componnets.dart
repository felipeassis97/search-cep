import 'package:flutter/material.dart';
import 'package:search_cep_project/app/core/utils/app_colors.dart';

class PrimaryButtonComponent extends StatelessWidget {
  final String labelButton;
  final VoidCallback onPressed;
  const PrimaryButtonComponent(
      {Key? key, required this.labelButton, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(labelButton),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          primary: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          textStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}
