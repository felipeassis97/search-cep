import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
        child: Lottie.asset('lib/app/assets/lotties/loading_lottie.json',
            width: 150, height: 150));
  }
}
