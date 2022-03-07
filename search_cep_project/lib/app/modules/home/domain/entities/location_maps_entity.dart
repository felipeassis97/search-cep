import 'package:equatable/equatable.dart';

class ListLocationMapsEntity extends Equatable {
  final List<LocationMapsEntity> results;
  final String? status;

  const ListLocationMapsEntity({required this.results, required this.status});

  @override
  List<Object?> get props => [results];
}

class LocationMapsEntity extends Equatable {
  final String? formattedAddress;
  final GeometryMapsEntity? geometry;
  const LocationMapsEntity(
      {required this.formattedAddress, required this.geometry});
  @override
  List<Object?> get props => [formattedAddress, geometry];
}

class GeometryMapsEntity extends Equatable {
  final LocationDataEntity? location;
  const GeometryMapsEntity({required this.location});
  @override
  List<Object?> get props => [location];
}

class LocationDataEntity extends Equatable {
  final double? lat;
  final double? lng;
  const LocationDataEntity({required this.lat, required this.lng});
  @override
  List<Object?> get props => [lat, lng];
}
