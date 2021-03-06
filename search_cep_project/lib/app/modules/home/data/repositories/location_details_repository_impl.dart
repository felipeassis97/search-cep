import 'package:search_cep_project/app/core/errors/exceptions.dart';
import 'package:search_cep_project/app/modules/home/data/datasource/search_cep/location_details_datasource.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:search_cep_project/app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:search_cep_project/app/modules/home/domain/repositories/location_details_repository.dart';

class LocationDetailsRepositoryImpl implements LocationDetailsRepository {
  final LocationDetailsDatasource datasource;

  LocationDetailsRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, LocationDetailsEntity>> getLocation(String cep) async {
    try {
      final result = await datasource.getDetailsLocation(cep);
      return Right(result);
    } on ServerExpection {
      return Left(ServerFailure());
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
