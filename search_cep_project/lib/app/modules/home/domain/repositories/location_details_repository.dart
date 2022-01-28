import 'package:dartz/dartz.dart';
import 'package:search_cep_project/app/core/errors/failures.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';

abstract class LocationDetailsRepository {
  Future<Either<Failure, LocationDetailsEntity>> getLocation(String cep);
}
