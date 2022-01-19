import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:search_cep_project/app/modules/home/presenter/stores/home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = 'Busca CEP'}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(color: Colors.red, height: 200, width: double.infinity),
            Container(color: Colors.blue, height: 200, width: double.infinity),
            Container(
                color: Colors.yellow, height: 200, width: double.infinity),
            Container(color: Colors.green, height: 200, width: double.infinity),
          ],
        ),
      ),
    );
  }
}
