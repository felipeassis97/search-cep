import 'package:flutter/material.dart';
import 'package:search_cep_project/app/core/utils/app_colors.dart';
import 'package:search_cep_project/app/modules/home/presenter/widgets/buttons_componnets.dart';

class CustomDialogComponent {
  final BuildContext context;

  final VoidCallback? onTapAccept;
  final String? textButtonAccept;

  final VoidCallback onTapCancel;
  final String textButtonCancel;

  final String titleMessage;
  final String? contentMessage;

  CustomDialogComponent(
      {required this.context,
      this.onTapAccept,
      this.textButtonAccept,
      required this.onTapCancel,
      required this.textButtonCancel,
      required this.titleMessage,
      this.contentMessage});

  showAlertDialog() {
    Widget declineButton = TextButton(
        child: Text(textButtonCancel),
        style: TextButton.styleFrom(
            primary: AppColors.primaryColor,
            textStyle: Theme.of(context).textTheme.button),
        onPressed: onTapCancel);

    Widget acceptButton = textButtonAccept != null && onTapAccept != null
        ? Padding(
            padding: const EdgeInsets.only(left: 16),
            child: PrimaryButtonComponent(
                minimunSizeHeight: 28,
                minimunSizeWidht: 30,
                labelButton: textButtonAccept!,
                onPressed: onTapAccept!),
          )
        : Container();

    AlertDialog alert = AlertDialog(
      content: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(titleMessage,
                    style: Theme.of(context).textTheme.headline6),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.warning,
                    color: AppColors.primaryColor,
                  ),
                )
              ],
            ),
          ),
          contentMessage != null
              ? Text(contentMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500))
              : const Text('')
        ],
      ),
      actions: [
        declineButton,
        textButtonAccept != null && onTapAccept != null
            ? acceptButton
            : Container()
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
