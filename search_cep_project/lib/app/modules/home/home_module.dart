import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_cep_project/app/core/client/search_cep_client_impl.dart';
import 'package:search_cep_project/app/modules/home/data/datasource/shared_preferences/shared_datasource_impl.dart';
import 'package:search_cep_project/app/modules/home/data/repositories/shared_repository_impl.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/shared_preferences/shared_usecase.dart';
import 'package:search_cep_project/app/modules/home/presenter/stores/home_store.dart';
import 'data/datasource/search_cep/location_details_datasource.dart';
import 'data/datasource/search_cep/location_details_datasource_impl.dart';
import 'data/repositories/location_details_repository_impl.dart';
import 'domain/repositories/location_details_repository.dart';
import 'domain/usecase/search_address/search_address_by_cep.dart';
import 'domain/usecase/search_address/search_address_by_cep_impl.dart';
import 'domain/usecase/shared_preferences/shared_usecase_impl.dart';
import 'presenter/screens/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
//Store
    Bind((i) => HomeStore(
          usecaseSearchCep: i<SearchLocationByCep>(),
          usecaseSharedPreferences: i<SharedPreferencesUsecase>(),
        )),

//Search Cep
    //Usecase
    Bind((i) => SearchAdressByCepUsecaseImpl(
        repository: i<LocationDetailsRepository>())),
    //Repository
    Bind((i) => LocationDetailsRepositoryImpl(
        datasource: i<LocationDetailsDatasource>())),
    //Datasource
    Bind(
        (i) => LocationDetailsDatasourceImpl(client: i<SearchCepClientImpl>())),

//Shared Preferences
    //Usecase
    Bind((i) => SharedPreferencesUsecaseImpl(
        repository: i<SharedPreferencesRepositoryImpl>())),
    //Repository
    Bind((i) => SharedPreferencesRepositoryImpl(
        datasource: i<SharedPreferencesDatasourceImpl>())),
    //Datasource
    Bind((i) => SharedPreferencesDatasourceImpl())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const HomePage()),
  ];
}
