import 'dart:convert';
import 'package:search_cep_project/app/modules/home/data/model/location_details_model.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressPreferencesService {
  Future<void> setUserInformation(LocationDetailsEntity address) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final addressData = jsonEncode(address);
      await prefs
          .setString('addressInformation', addressData)
          .catchError((e) => throw e);
    } on Exception {
      throw Exception();
    }
  }

  Future<dynamic> getUserInformation() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final addressData = (prefs.getString('addressInformation') ?? "");
      final addressModel = jsonDecode(addressData);
      final addressEntity = LocationDetailsModel.fromJson(addressModel);
      return addressEntity;
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
