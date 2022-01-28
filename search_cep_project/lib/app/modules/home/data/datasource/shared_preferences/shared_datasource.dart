import 'package:search_cep_project/app/modules/home/data/model/location_details_model.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';

abstract class SharedPreferencesDatasource {
  Future<List<LocationDetailsModel>> getDataSharedPreferences();
  Future<void> setDataSharedPreferences(
      List<LocationDetailsEntity> addressShared);
  Future<void> clearDataSharedPreferences();
}
