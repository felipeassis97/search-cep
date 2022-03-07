import 'package:search_cep_project/app/modules/home/data/model/location_maps_model.dart';

abstract class LocationByMapsDatasource {
  Future<List<LocationMapsModel>> call(String place);
}
