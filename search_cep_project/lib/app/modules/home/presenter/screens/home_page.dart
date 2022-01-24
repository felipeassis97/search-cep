import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:mobx/mobx.dart';
import 'package:search_cep_project/app/core/utils/app_assets.dart';
import 'package:search_cep_project/app/core/utils/app_colors.dart';
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
                      padding: const EdgeInsets.all(32.0),
                      child: _textFieldSearch(),
                    ),
                    store.dataAddressByCep != null
                        ? card(store.dataAddressByCep!.logradouro,
                            store.dataAddressByCep!.localidade)
                        : _emptyState(),
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
    return TextField(
      controller: _inpuCep,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.place),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(20)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintText: 'Digite o cep que deseja buscar',
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = PrimaryButtonComponent(
        labelButton: 'Fechar', onPressed: () => Navigator.pop(context));

    AlertDialog alert = AlertDialog(
      title: Center(
        child: Lottie.asset(AppAssets.errorAnimation, width: 70, height: 70),
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

  Widget card(String city, String state) {
    return SizedBox(
      width: 300,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: AppColors.neutralColorHightPure,
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: SvgPicture.asset(
                AppAssets.directionsIllustration,
                height: 70,
                width: 70,
              ),
              title: Text(city, style: TextStyle(color: Colors.black)),
              subtitle: Text(state, style: TextStyle(color: Colors.black)),
            ),
            ButtonTheme(
              child: ButtonBar(
                children: <Widget>[
                  TextButton(
                    child: const Text('Delete',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Column(
      children: [
        SvgPicture.asset(
          AppAssets.addressIllustration,
          height: 200,
          width: 200,
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Voce ainda não fez uma busca",
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _reactionCep();
    super.dispose();
  }
}
