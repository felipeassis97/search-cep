import 'dart:developer';

import 'package:search_cep_project/app/core/client/serarch_cep_client_i.dart';
import 'package:search_cep_project/app/core/errors/exceptions.dart';
import 'package:search_cep_project/app/modules/home/data/datasource/endpoints/search_cep_endpoints.dart';
import 'package:search_cep_project/app/modules/home/data/datasource/location_by_maps/location_by_maps_datasource.dart';
import 'package:search_cep_project/app/modules/home/data/model/location_maps_model.dart';

class LocationByMapsDatasourceImpl implements LocationByMapsDatasource {
  final ISearchCepClient client;

  LocationByMapsDatasourceImpl(this.client);

  @override
  Future<List<LocationMapsModel>> call(String place) async {
    final response = await client.get(SearchCepEndpoint.maps(place));
    if (response.statusCode == 200 && response.data != null) {
      final list = response.data;

      final list2 = List.from(list["results"]);

      log("LIST 2: $list2");

      return list2.map((location) {
        log("LIST RESULT: ${location["results"]}");
        return LocationMapsModel.fromJson(location);
      }).toList();
    } else {
      throw ServerExpection();
    }
  }
}
