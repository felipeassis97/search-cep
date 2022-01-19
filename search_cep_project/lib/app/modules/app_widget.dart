import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busca cep',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.archivoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
    ).modular();
  }
}
