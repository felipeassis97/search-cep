import 'package:search_cep_project/app/core/errors/exceptions.dart';
import 'package:search_cep_project/app/modules/home/data/datasource/shared_preferences/shared_datasource.dart';
import 'package:search_cep_project/app/modules/home/data/model/location_details_model.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDatasourceImpl implements SharedPreferencesDatasource {
  @override
  Future<List<LocationDetailsModel>> getDataSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final addressData = (prefs.getStringList('addressInformation') ?? []);

      final list = List.from(addressData);
      return list
          .map<LocationDetailsModel>(
              (addressModel) => LocationDetailsModel.fromJson(addressModel))
          .toList();

      // final addressModel = jsonDecode(addressData);
      // final addressEntity = LocationDetailsModel.fromJson(addressModel);
      // return addressEntity;

    } on Exception {
      throw SharedException();
    }
  }

  @override
  Future<void> setDataSharedPreferences(
      List<LocationDetailsEntity> addressShared) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //final addressData = jsonEncode(addressShared);
      List<String> list = List.from(addressShared);
      //  list
      //     .map<LocationDetailsModel>(
      //         (addressModel) => LocationDetailsModel.fromJson(addressShared))
      //     .toList();

      await prefs.setStringList('addressInformation', list);
    } on Exception {
      throw SharedException();
    }
  }

  @override
  Future<void> clearDataSharedPreferences() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
    } on Exception {
      throw SharedException();
    }
  }
}
