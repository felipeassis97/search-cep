import 'package:flutter/material.dart';
import 'package:search_cep_project/app/core/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final bool centerTitle;
  const CustomAppBar(
      {Key? key,
      required this.title,
      this.height = 60,
      this.centerTitle = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(120),
      child: AppBar(
        centerTitle: centerTitle,
        title: Text(title),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: MediaQuery.of(context).size.height / 4,
        leading: Container(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
