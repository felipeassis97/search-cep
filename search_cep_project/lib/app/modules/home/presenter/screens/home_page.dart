import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:mobx/mobx.dart';
import 'package:search_cep_project/app/core/utils/app_assets.dart';
import 'package:search_cep_project/app/core/utils/app_colors.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:search_cep_project/app/modules/home/presenter/stores/home_store.dart';
import 'package:search_cep_project/app/modules/home/presenter/widgets/buttons_componnets.dart';
import 'package:search_cep_project/app/theme/custom_app_bar.dart';
import 'package:search_cep_project/app/theme/custom_dialog.dart';
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

    store.getSharedPreferences();

    _reactionCep = reaction(
        (_) => store.requestError,
        (_) => store.requestError == true
            ? CustomDialogComponent(
                    context: context,
                    onTapCancel: () {
                      Navigator.pop(context);
                    },
                    titleMessage: "Atenção",
                    contentMessage:
                        "Ocorreu um erro.\nVerifique o cep informado e tente novamente.",
                    textButtonCancel: "Fechar")
                .showAlertDialog()
            : null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Search Cep',
        centerTitle: true,
      ),
      body: Observer(builder: (context) {
        return store.isLoading
            ? const CustomProgressIndicator()
            : Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 72),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        _textFieldSearch(),
                        store.dataAddressByCep != null
                            ? Column(
                                children: [
                                  _card(store.dataAddressByCep),
                                  _goToMaps(),
                                  _buttonAddFavorites()
                                ],
                              )
                            : _emptyState(),
                        _listItems()
                      ],
                    ),
                  ),
                  _buttonSubmit(),
                ],
              );
      }),
    );
  }

  Widget _labelFavorites() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 4),
      child: Row(
        children: const [
          Text("Favoritos",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          SizedBox(width: 8),
          Icon(Icons.star_border_outlined, color: AppColors.primaryColor)
        ],
      ),
    );
  }

  Widget _buttonAddFavorites() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: InkWell(
        onTap: () async {
          if (store.dataAddressByCep != null) {
            await store.getSharedPreferences();
            var currentAddress = store.dataAddressByCep;
            store.currentDataAddressShared.add(currentAddress!);
            await store.setSharedPreferences(store.currentDataAddressShared);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Adicionar aos favoritos",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(width: 8),
            Icon(Icons.add, color: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _goToMaps() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      child: InkWell(
        onTap: () {
          Modular.to
              .navigate('/maps', arguments: store.dataAddressByCep!.logradouro);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Ver no mapa",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(width: 8),
            Icon(Icons.place_rounded, color: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buttonClear() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 4),
      child: InkWell(
        onTap: () async {
          CustomDialogComponent(
                  context: context,
                  onTapCancel: () {
                    Navigator.pop(context);
                  },
                  textButtonAccept: "Excluir",
                  onTapAccept: () async {
                    await store.clearSharedPreferences();
                    Navigator.pop(context);
                  },
                  titleMessage: "Atenção",
                  contentMessage:
                      "Todos os itens serão excluídos.\nVocê deseja realmente excluir?",
                  textButtonCancel: "Cancelar")
              .showAlertDialog();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text("Limpar",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(width: 8),
            Icon(Icons.delete_forever, color: AppColors.primaryColor)
          ],
        ),
      ),
    );
  }

  Widget _buttonSubmit() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: PrimaryButtonComponent(
            labelButton: 'Buscar',
            onPressed: () async {
              await store.searchCep(_inpuCep.text);
              //  await store.actualPosition();
            }),
      ),
    );
  }

  Widget _listItems() {
    return Observer(builder: (context) {
      return store.currentDataAddressShared.isNotEmpty
          ? Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Divider(thickness: 1),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [_labelFavorites(), _buttonClear()]),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: store.currentDataAddressShared.length,
                    itemBuilder: (context, i) {
                      final item = i;
                      return Column(
                        children: [
                          Dismissible(
                            background: slideLeftBackground(),
                            secondaryBackground: null,
                            key: Key(item.toString()),
                            onDismissed: (DismissDirection direction) {
                              if (direction == DismissDirection.startToEnd) {
                              } else {}
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              child: _card(store.currentDataAddressShared[i]),
                            ),
                          ),
                        ],
                      );
                    }),
              ],
            )
          : _emptyStateFavorites();
    });
  }

  Widget _textFieldSearch() {
    return TextField(
      controller: _inpuCep,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.place),
        suffixIcon: InkWell(
            onTap: () => store.dataAddressByCep = null,
            child: const Icon(Icons.clear)),
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

  Widget slideLeftBackground() {
    return Container(
      color: AppColors.primaryColor,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Icon(Icons.delete, color: Colors.white),
            SizedBox(width: 8),
            Text("Delete",
                style: TextStyle(
                    color: AppColors.neutralColorHightPure,
                    fontWeight: FontWeight.w700)),
            SizedBox(width: 20),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Widget _card(LocationDetailsEntity? dataAddress) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: AppColors.neutralColorHightPure,
            elevation: 6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  leading: SvgPicture.asset(
                    AppAssets.directionsIllustration,
                    height: 85,
                    width: 85,
                  ),
                  title: Row(
                    children: [
                      const Icon(Icons.location_city_outlined,
                          color: AppColors.secondaryColorLight),
                      const Padding(padding: EdgeInsets.only(left: 8)),
                      Text(dataAddress!.cep,
                          style: Theme.of(context).textTheme.headline6),
                    ],
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.streetview_outlined,
                              color: AppColors.secondaryColorLight),
                          const Padding(padding: EdgeInsets.only(left: 8)),
                          Text(dataAddress.logradouro,
                              style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_city_outlined,
                              color: AppColors.secondaryColorLight),
                          const Padding(padding: EdgeInsets.only(left: 8)),
                          Text(dataAddress.bairro,
                              style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.outlined_flag,
                              color: AppColors.secondaryColorLight),
                          const Padding(padding: EdgeInsets.only(left: 8)),
                          Row(
                            children: [
                              Text(dataAddress.localidade,
                                  style: Theme.of(context).textTheme.subtitle1),
                              const Text(", "),
                              Text(dataAddress.uf,
                                  style: Theme.of(context).textTheme.subtitle1),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: SvgPicture.asset(
            AppAssets.addressIllustration,
            height: 80,
            width: 80,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            "Voce ainda não fez uma busca",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }

  Widget _emptyStateFavorites() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 64),
          child: SvgPicture.asset(
            AppAssets.favoriteIllustration,
            height: 80,
            width: 80,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            "Você ainda não tem nenhum favorito :(",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
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
