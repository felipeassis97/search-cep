import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:search_cep_project/app/core/utils/app_assets.dart';

class CustomProgressIndicator extends StatefulWidget {
  const CustomProgressIndicator({Key? key}) : super(key: key);

  @override
  State<CustomProgressIndicator> createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            Lottie.asset(AppAssets.loadingAnimation, width: 150, height: 150));
  }
}
