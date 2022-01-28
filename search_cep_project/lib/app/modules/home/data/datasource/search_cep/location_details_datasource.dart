import 'package:search_cep_project/app/modules/home/data/model/location_details_model.dart';

abstract class LocationDetailsDatasource {
  Future<LocationDetailsModel> getDetailsLocation(String cep);
}
