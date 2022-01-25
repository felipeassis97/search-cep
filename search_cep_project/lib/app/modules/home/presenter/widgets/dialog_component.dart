import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:search_cep_project/app/core/utils/app_assets.dart';
import 'package:search_cep_project/app/core/utils/app_colors.dart';

class DialogComponent {
  final BuildContext context;
  final String labelButton;
  final VoidCallback onPressed;

  DialogComponent(
      {required this.context,
      required this.labelButton,
      required this.onPressed});

  showAlertDialog() {
    Widget okButton = TextButton(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            labelButton,
            style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
          ),
        ),
        onPressed: onPressed);

    AlertDialog alert = AlertDialog(
      title: Center(
        child: Lottie.asset(AppAssets.errorAnimation, width: 70, height: 70),
      ),
      content: Wrap(
        children: const [
          Text("Ocorreu um erro.\nVerifique o Cep infornado e tente novamente.",
              textAlign: TextAlign.center),
        ],
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
