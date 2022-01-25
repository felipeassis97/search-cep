import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_cep_project/app/core/utils/app_colors.dart';
import 'package:search_cep_project/app/theme/custom_text_theme.dart';

class SearchCepApp extends StatelessWidget {
  const SearchCepApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busca cep',
      theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.neutralColorHightPure,
          textTheme: CustomTextTheme.textTheme),
      debugShowCheckedModeBanner: false,
    ).modular();
  }
}
