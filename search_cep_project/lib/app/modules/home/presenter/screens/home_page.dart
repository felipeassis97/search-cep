import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:search_cep_project/app/modules/home/presenter/stores/home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = 'Busca CEP'}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get();
  final _inpuCep = TextEditingController();
  late final ReactionDisposer reactionCep;

  @override
  void initState() {
    super.initState();

    reactionCep = reaction((_) => store.requestError, (_) => print('REACTION'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(builder: (context) {
        return store.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(controller: _inpuCep),
                      ),
                      store.dataAddressByCep != null
                          ? Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(store.dataAddressByCep!.logradouro),
                                  Text(store.dataAddressByCep!.localidade),
                                  Text(store.dataAddressByCep!.uf),
                                ],
                              ),
                            )
                          : Column(),
                      ElevatedButton(
                          onPressed: () async {
                            await store.searchCep(_inpuCep.text);
                          },
                          child: const Text('Buscar'))
                    ],
                  ),
                ),
              );
      }),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Atenção"),
      content: const Text("Ocorreu um erro"),
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

  @override
  void dispose() {
    reactionCep();
    super.dispose();
  }
}
