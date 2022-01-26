import 'dart:convert';

import 'package:search_cep_project/app/core/errors/exceptions.dart';
import 'package:search_cep_project/app/modules/home/data/datasource/shared_preferences/set_shared_datasource.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetSharedPreferencesDatasourceImpl
    implements SetSharedPreferencesDatasource {
  @override
  Future<void> call(LocationDetailsEntity addressShared) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final addressData = jsonEncode(addressShared);
      await prefs.setString('addressInformation', addressData);
    } on Exception {
      throw ServerExpection();
    }
  }
}
