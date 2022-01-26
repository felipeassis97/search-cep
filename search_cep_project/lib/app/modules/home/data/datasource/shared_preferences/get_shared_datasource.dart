import 'package:search_cep_project/app/modules/home/data/model/location_details_model.dart';

abstract class GetSharedPreferencesDatasource {
  Future<LocationDetailsModel> call();
}
