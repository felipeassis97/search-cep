import 'dart:convert';

import 'package:search_cep_project/app/modules/home/data/model/location_details_model.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressPreferencesService {
  Future<void> setUserInformation(LocationDetailsEntity dataAddress) async {
    try {
      SharedPreferences.setMockInitialValues({});
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final userData = jsonEncode(dataAddress);
      await prefs
          .setString('userInformation', userData)
          .catchError((e) => throw e);
    } on Exception {
      throw Exception();
    }
  }

  Future<LocationDetailsEntity> getUserInformation() async {
    try {
      SharedPreferences.setMockInitialValues({});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userData = (prefs.getString('userInformation') ?? "");
      final user = jsonDecode(userData);

      final userModel = LocationDetailsModel.fromJson(user);
      print("GET: $userModel");
      return userModel;
    } on Exception catch (e) {
      throw e;
    }
  }

  Future clearSharedPreferences() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
    } on Exception catch (e) {
      throw e;
    }
  }
}
