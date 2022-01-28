import 'package:search_cep_project/app/core/client/serarch_cep_client_i.dart';
import 'package:search_cep_project/app/core/errors/exceptions.dart';
import 'package:search_cep_project/app/modules/home/data/datasource/endpoints/search_cep_endpoints.dart';
import 'package:search_cep_project/app/modules/home/data/model/location_details_model.dart';

import 'location_details_datasource.dart';

class LocationDetailsDatasourceImpl implements LocationDetailsDatasource {
  final ISearchCepClient client;

  LocationDetailsDatasourceImpl({required this.client});
  @override
  Future<LocationDetailsModel> getDetailsLocation(String cep) async {
    final response = await client.get(SearchCepEndpoint.path(cep));
    if (response.statusCode == 200 && response.data != null) {
      return LocationDetailsModel.fromJson(response.data);
    } else {
      throw ServerExpection();
    }
  }
}
