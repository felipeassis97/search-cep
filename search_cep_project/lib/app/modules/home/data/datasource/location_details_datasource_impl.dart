import 'package:search_cep_project/app/core/client/search_cep_client.dart';
import 'package:search_cep_project/app/core/errors/exceptions.dart';
import 'package:search_cep_project/app/core/services/address_preferences_service.dart';
import 'package:search_cep_project/app/modules/home/data/datasource/location_details_datasource.dart';
import 'package:search_cep_project/app/modules/home/data/model/location_details_model.dart';

import 'endpoints/search_cep_endpoints.dart';

class LocationDetailsDatasourceImpl implements LocationDetailsDatasource {
  final SearchCepClient client;

  LocationDetailsDatasourceImpl({required this.client});
  @override
  Future<LocationDetailsModel> call(String cep) async {
    final response = await client.get(SearchCepEndpoint.path(cep));
    if (response.statusCode == 200) {
      final result = LocationDetailsModel.fromJson(response.data);
      await AddressPreferencesService().setUserInformation(result);

      return result;
    } else if (response.statusCode == 400) {
      throw ServerExpection();
    } else {
      throw Exception();
    }
  }
}
