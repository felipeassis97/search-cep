import 'package:search_cep_project/app/modules/home/domain/entities/location_maps_entity.dart';

class LocationMapsModel extends LocationMapsEntity {
  const LocationMapsModel({required String formattedAddress, required geometry})
      : super(formattedAddress: formattedAddress, geometry: geometry);

  factory LocationMapsModel.fromJson(Map<String, dynamic> json) =>
      LocationMapsModel(
          formattedAddress: json['formattedAddress'] ?? "",
          geometry: GeometryMapsModel.fromJson(json['geometry']));
}

class GeometryMapsModel extends GeometryMapsEntity {
  const GeometryMapsModel({required location}) : super(location: location);

  factory GeometryMapsModel.fromJson(Map<String, dynamic> json) =>
      GeometryMapsModel(location: LocationDataModel.fromJson(json['location']));
}

class LocationDataModel extends LocationDataEntity {
  const LocationDataModel({required lat, required lng})
      : super(lat: lat, lng: lng);
  factory LocationDataModel.fromJson(Map<String, dynamic> json) =>
      LocationDataModel(lat: json['lat'], lng: json['lng']);
}
