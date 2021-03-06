import 'package:search_cep_project/app/core/errors/exceptions.dart';
import 'package:search_cep_project/app/modules/home/data/datasource/shared_preferences/shared_datasource.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:search_cep_project/app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:search_cep_project/app/modules/home/domain/repositories/shared_repository.dart';

class SharedPreferencesRepositoryImpl implements SharedPreferencesRepository {
  final SharedPreferencesDatasource datasource;

  SharedPreferencesRepositoryImpl({required this.datasource});
  @override
  Future<Either<Failure, List<LocationDetailsEntity>>>
      getDataSharedPreferences() async {
    try {
      final result = await datasource.getDataSharedPreferences();
      return Right(result);
    } on ServerExpection {
      return Left(ServerFailure());
    } on Exception {
      return Left(SharedFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setDataSharedPreferences(
      List<LocationDetailsEntity> addressEntity) async {
    try {
      await datasource.setDataSharedPreferences(addressEntity);
      return const Right(null);
    } catch (_) {
      return Left(SharedFailure());
    }
  }

  @override
  Future<Either<Failure, void>> clearDataSharedPreferences() async {
    try {
      await datasource.clearDataSharedPreferences();
      return const Right(null);
    } catch (_) {
      return Left(SharedFailure());
    }
  }
}
