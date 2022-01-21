import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_cep_project/app/modules/home/presenter/stores/home_store.dart';
import 'data/datasource/location_details_datasource_impl.dart';
import 'data/repositories/location_details_repository_impl.dart';
import 'domain/usecase/search_address_by_cep_impl.dart';
import 'presenter/screens/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => HomeStore(searchCepUsecase: i())),
    Bind(
        (i) => SearchAdressByCepUsecaseImpl(searchAddreesByCepRepository: i())),
    Bind((i) =>
        LocationDetailsRepositoryImpl(searchAddressByCepDatasource: i())),
    Bind((i) => LocationDetailsDatasourceImpl())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const HomePage()),
  ];
}
