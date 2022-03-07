import 'dart:convert';

import 'package:search_cep_project/app/core/errors/exceptions.dart';
import 'package:search_cep_project/app/modules/home/data/datasource/shared_preferences/shared_datasource.dart';
import 'package:search_cep_project/app/modules/home/data/model/location_details_model.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDatasourceImpl implements SharedPreferencesDatasource {
  @override
  Future<List<LocationDetailsModel>> getDataSharedPreferences() async {
    var _items = <LocationDetailsModel>[];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final addressData = (prefs.getStringList('addressInformation') ?? []);
      if (addressData.isEmpty) {
        final List<LocationDetailsModel> _response = [];
        return _response;
      } else {
        for (var addressShared in addressData) {
          final response = jsonDecode(addressShared);
          final response2 = LocationDetailsModel.fromJson(response);
          _items.add(response2);
        }

        return _items;
      }
    } on Exception {
      throw SharedException();
    }
  }

  @override
  Future<void> setDataSharedPreferences(
      List<LocationDetailsEntity> addressShared) async {
    var _items = <String>[];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      for (var addressShared in addressShared) {
        final response = jsonEncode(addressShared);
        _items.add(response);
      }
      await prefs.setStringList('addressInformation', _items);
      await getDataSharedPreferences();
    } on Exception {
      throw SharedException();
    }
  }

  @override
  Future<void> clearDataSharedPreferences() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      await getDataSharedPreferences();
    } on Exception {
      throw SharedException();
    }
  }
}
