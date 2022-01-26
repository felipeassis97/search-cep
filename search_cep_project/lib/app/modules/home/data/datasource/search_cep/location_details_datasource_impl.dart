import 'package:search_cep_project/app/core/client/search_cep_client.dart';
import 'package:search_cep_project/app/core/errors/exceptions.dart';
import 'package:search_cep_project/app/modules/home/data/datasource/endpoints/search_cep_endpoints.dart';
import 'package:search_cep_project/app/modules/home/data/model/location_details_model.dart';

import 'location_details_datasource.dart';

class LocationDetailsDatasourceImpl implements LocationDetailsDatasource {
  final SearchCepClient client;

  LocationDetailsDatasourceImpl({required this.client});
  @override
  Future<LocationDetailsModel> call(String cep) async {
    final response = await client.get(SearchCepEndpoint.path(cep));
    if (response.statusCode == 200) {
      return LocationDetailsModel.fromJson(response.data);
    } else if (response.statusCode == 400) {
      throw ServerExpection();
    } else {
      throw Exception();
    }
  }
}
