import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:search_cep_project/app/modules/home/presenter/widgets/buttons_componnets.dart';

class DialogComponent {
  final BuildContext context;
  final String labelButton;
  final VoidCallback onPressed;

  DialogComponent(
      {required this.context,
      required this.labelButton,
      required this.onPressed});

  showAlertDialog() {
    Widget okButton =
        PrimaryButtonComponent(labelButton: labelButton, onPressed: onPressed);

    AlertDialog alert = AlertDialog(
      title: Center(
        child: Lottie.asset('lib/app/assets/lotties/error_lottie.json',
            width: 70, height: 70),
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
