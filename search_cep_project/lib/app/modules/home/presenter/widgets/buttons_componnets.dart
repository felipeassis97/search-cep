import 'package:flutter/material.dart';
import 'package:search_cep_project/app/core/utils/app_colors.dart';

class PrimaryButtonComponent extends StatelessWidget {
  final String labelButton;
  final VoidCallback onPressed;
  final double minimunSizeWidht;
  final double minimunSizeHeight;
  const PrimaryButtonComponent(
      {Key? key,
      required this.labelButton,
      required this.onPressed,
      this.minimunSizeHeight = 50,
      this.minimunSizeWidht = 150})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(labelButton),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          minimumSize: Size(minimunSizeWidht, minimunSizeHeight),
          primary: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          textStyle: Theme.of(context).textTheme.button),
    );
  }
}
