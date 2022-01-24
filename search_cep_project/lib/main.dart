import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_cep_project/app/modules/search_cep_app.dart';
import 'app/modules/main_module.dart';

void main() {
  runApp(ModularApp(module: MainModule(), child: const SearchCepApp()));
}
