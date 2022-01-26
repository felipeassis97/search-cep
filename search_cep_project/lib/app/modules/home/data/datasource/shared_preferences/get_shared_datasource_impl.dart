import 'dart:convert';

import 'package:search_cep_project/app/core/errors/exceptions.dart';
import 'package:search_cep_project/app/modules/home/data/datasource/shared_preferences/get_shared_datasource.dart';
import 'package:search_cep_project/app/modules/home/data/model/location_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetSharedPreferencesDatasourceImpl
    implements GetSharedPreferencesDatasource {
  @override
  Future<LocationDetailsModel> call() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final addressData = (prefs.getString('addressInformation') ?? "");
      final addressModel = jsonDecode(addressData);
      final addressEntity = LocationDetailsModel.fromJson(addressModel);
      return addressEntity;
    } on Exception {
      throw ServerExpection();
    }
  }
}
