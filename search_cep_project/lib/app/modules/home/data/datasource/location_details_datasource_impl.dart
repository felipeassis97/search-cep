import 'package:dio/dio.dart';
import 'package:search_cep_project/app/core/errors/exceptions.dart';
import 'package:search_cep_project/app/modules/home/data/datasource/location_details_datasource.dart';
import 'package:search_cep_project/app/modules/home/data/model/location_details_model.dart';

class LocationDetailsDatasourceImpl implements LocationDetailsDatasource {
  @override
  Future<LocationDetailsModel> call(String cep) async {
    final _client = Dio(); //

    final response = await _client.get('https://viacep.com.br/ws/$cep/json/');

    if (response.statusCode == 200) {
      return LocationDetailsModel.fromJson(response.data);
    } else if (response.statusCode == 400) {
      throw ServerExpection();
    } else {
      throw Exception();
    }
  }
}
