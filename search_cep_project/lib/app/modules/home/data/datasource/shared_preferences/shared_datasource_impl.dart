import 'dart:convert';

import 'package:search_cep_project/app/core/errors/exceptions.dart';
import 'package:search_cep_project/app/modules/home/data/datasource/shared_preferences/shared_datasource.dart';
import 'package:search_cep_project/app/modules/home/data/model/location_details_model.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDatasourceImpl implements SharedPreferencesDatasource {
  @override
  Future<LocationDetailsModel> getDataSharedPreferences() async {
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

  @override
  Future<void> setDataSharedPreferences(
      LocationDetailsEntity addressShared) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final addressData = jsonEncode(addressShared);
      await prefs.setString('addressInformation', addressData);
    } on Exception {
      throw ServerExpection();
    }
  }

  @override
  Future<void> clearDataSharedPreferences() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
    } on Exception {
      throw ServerExpection();
    }
  }
}
