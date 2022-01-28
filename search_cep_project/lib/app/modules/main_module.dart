import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_cep_project/app/core/client/search_cep_client_impl.dart';
import 'package:search_cep_project/app/modules/home/home_module.dart';

class MainModule extends Module {
  @override
  final List<Bind> binds = [
    //Client
    Bind.factory(
        (i) => Dio(BaseOptions(connectTimeout: 1000, receiveTimeout: 1000))),
    Bind.factory((i) => SearchCepClientImpl(client: i<Dio>()))
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: HomeModule()),
  ];
}
