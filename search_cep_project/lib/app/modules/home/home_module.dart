import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_cep_project/app/core/client/search_cep_client.dart';
import 'package:search_cep_project/app/modules/home/data/datasource/shared_preferences/get_shared_datasource_impl.dart';
import 'package:search_cep_project/app/modules/home/data/repositories/get_shared_repository_impl.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/shared_preferences/get_address_shared.dart';
import 'package:search_cep_project/app/modules/home/presenter/stores/home_store.dart';
import 'data/datasource/search_cep/location_details_datasource.dart';
import 'data/datasource/search_cep/location_details_datasource_impl.dart';
import 'data/datasource/shared_preferences/set_shared_datasource_impl.dart';
import 'data/repositories/location_details_repository_impl.dart';
import 'data/repositories/set_shared_repository_impl.dart';
import 'domain/repositories/location_details_repository.dart';
import 'domain/usecase/search_address/search_address_by_cep.dart';
import 'domain/usecase/search_address/search_address_by_cep_impl.dart';
import 'domain/usecase/shared_preferences/get_address_shared_impl.dart';
import 'domain/usecase/shared_preferences/set_address_shared.dart';
import 'domain/usecase/shared_preferences/set_address_shared_impl.dart';
import 'presenter/screens/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
//Store
    Bind((i) => HomeStore(
        usecase: i<SearchLocationByCep>(),
        usecaseSetSharedPreferences: i<SetAddressSharedPreferences>(),
        usecaseGetSharedPreferences: i<GetAddressSharedPreferences>())),

//Search Cep
    //Usecase
    Bind((i) => SearchAdressByCepUsecaseImpl(
        repository: i<LocationDetailsRepository>())),
    //Repository
    Bind((i) => LocationDetailsRepositoryImpl(
        datasource: i<LocationDetailsDatasource>())),
    //Datasource
    Bind((i) => LocationDetailsDatasourceImpl(client: i<SearchCepClient>())),

//Set Shared Preferences
    //Usecase
    Bind((i) => SetAddressSharedPreferencesImpl(
        repository: i<SetSharedPreferencesRepositoryImpl>())),
    //Repository
    Bind((i) => SetSharedPreferencesRepositoryImpl(
        datasource: i<SetSharedPreferencesDatasourceImpl>())),
    //Datasource
    Bind((i) => SetSharedPreferencesDatasourceImpl()),

//Get Shared Preferences
    //Usecase
    Bind((i) => GetAddressSharedPreferencesImpl(
        repository: i<GetSharedPreferencesRepositoryImpl>())),
    //Repository
    Bind((i) => GetSharedPreferencesRepositoryImpl(
        datasource: i<GetSharedPreferencesDatasourceImpl>())),
    //Datasource
    Bind((i) => GetSharedPreferencesDatasourceImpl()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const HomePage()),
  ];
}
