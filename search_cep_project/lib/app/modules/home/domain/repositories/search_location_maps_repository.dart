import 'package:dartz/dartz.dart';
import 'package:search_cep_project/app/core/errors/failures.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_maps_entity.dart';

abstract class SearchLocationMapsRepository {
  Future<Either<Failure, List<LocationMapsEntity>>> call(String place);
}
