import 'package:flutter/material.dart';
import 'package:search_cep_project/app/core/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  const CustomAppBar({Key? key, required this.title, this.height = 60})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(120),
      child: AppBar(
        title: Text(title),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
