import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobx/mobx.dart';
import 'package:search_cep_project/app/modules/home/presenter/stores/home_store.dart';
import 'package:search_cep_project/app/modules/home/presenter/widgets/buttons_componnets.dart';
import 'package:search_cep_project/app/modules/home/presenter/widgets/dialog_component.dart';
import 'package:search_cep_project/app/theme/custom_app_bar.dart';
import 'package:search_cep_project/app/theme/custom_progress_indicator.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = 'Busca CEP'}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get();
  final _inpuCep = TextEditingController();
  late final ReactionDisposer _reactionCep;

  @override
  void initState() {
    super.initState();

    _reactionCep = reaction(
        (_) => store.requestError,
        (_) => store.requestError == true
            ? DialogComponent(
                labelButton: 'Fechar',
                context: context,
                onPressed: () => Navigator.pop(context)).showAlertDialog()
            : null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Search Cep'), body: _body());
  }

  Widget _body() {
    return Observer(builder: (context) {
      return store.isLoading
          ? const CustomProgressIndicator()
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _textFieldSearch(),
                    ),
                    store.dataAddressByCep != null
                        ? _dataAddressComponent()
                        : Column(),
                    PrimaryButtonComponent(
                        labelButton: 'Buscar',
                        onPressed: () async {
                          await store.searchCep(_inpuCep.text);
                        })
                  ],
                ),
              ),
            );
    });
  }

  Widget _textFieldSearch() {
    return TextFormField(controller: _inpuCep);
  }

  Widget _dataAddressComponent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(store.dataAddressByCep!.logradouro),
          Text(store.dataAddressByCep!.localidade),
          Text(store.dataAddressByCep!.uf),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = PrimaryButtonComponent(
        labelButton: 'Fechar', onPressed: () => Navigator.pop(context));

    AlertDialog alert = AlertDialog(
      title: Center(
        child: Lottie.asset('lib/app/assets/lotties/error_lottie.json',
            width: 70, height: 70),
      ),
      content: Wrap(
        children: const [
          Text("Ocorreu um erro.\nVerifique o Cep infornado e tente novamente.",
              textAlign: TextAlign.center),
        ],
      ),
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
    _reactionCep();
    super.dispose();
  }
}
