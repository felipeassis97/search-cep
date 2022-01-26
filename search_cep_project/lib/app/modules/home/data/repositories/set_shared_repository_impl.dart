import 'package:search_cep_project/app/modules/home/data/datasource/shared_preferences/set_shared_datasource.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:search_cep_project/app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:search_cep_project/app/modules/home/domain/repositories/set_shared_repository.dart';

class SetSharedPreferencesRepositoryImpl implements SetSharedRepository {
  final SetSharedPreferencesDatasource datasource;

  SetSharedPreferencesRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, void>> call(
      LocationDetailsEntity addressEntity) async {
    try {
      await datasource.call(addressEntity);
      return const Right(null);
    } catch (_) {
      return Left(ServerFailure());
    }
  }
}
