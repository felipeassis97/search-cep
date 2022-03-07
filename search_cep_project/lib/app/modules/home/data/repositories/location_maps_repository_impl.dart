import 'package:search_cep_project/app/core/errors/exceptions.dart';
import 'package:search_cep_project/app/modules/home/data/datasource/location_by_maps/location_by_maps_datasource.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_maps_entity.dart';
import 'package:search_cep_project/app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:search_cep_project/app/modules/home/domain/repositories/search_location_maps_repository.dart';

class LocationMapsRepositoryImpl implements SearchLocationMapsRepository {
  final LocationByMapsDatasource datasource;

  LocationMapsRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<LocationMapsEntity>>> call(String place) async {
    try {
      final result = await datasource.call(place);
      return Right(result);
    } on ServerExpection {
      return Left(ServerFailure());
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
