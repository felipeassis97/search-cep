import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';

abstract class SetSharedPreferencesDatasource {
  Future<void> call(LocationDetailsEntity addressShared);
}
