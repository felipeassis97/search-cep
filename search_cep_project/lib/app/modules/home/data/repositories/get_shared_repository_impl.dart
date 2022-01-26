import 'package:search_cep_project/app/core/errors/exceptions.dart';
import 'package:search_cep_project/app/modules/home/data/datasource/shared_preferences/get_shared_datasource.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:search_cep_project/app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:search_cep_project/app/modules/home/domain/repositories/get_shared_repository.dart';

class GetSharedPreferencesRepositoryImpl
    implements GetSharedPreferencesRepository {
  final GetSharedPreferencesDatasource datasource;

  GetSharedPreferencesRepositoryImpl({required this.datasource});
  @override
  Future<Either<Failure, LocationDetailsEntity>> call() async {
    try {
      final result = await datasource.call();
      return Right(result);
    } on ServerExpection {
      return Left(ServerFailure());
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
