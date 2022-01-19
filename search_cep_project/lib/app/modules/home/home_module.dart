import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_cep_project/app/modules/home/presenter/stores/home_store.dart';
import 'presenter/screens/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [Bind((i) => HomeStore())];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const HomePage()),
  ];
}
