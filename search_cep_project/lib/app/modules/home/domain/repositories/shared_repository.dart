import 'package:dartz/dartz.dart';
import 'package:search_cep_project/app/core/errors/failures.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';

abstract class SharedPreferencesRepository {
  Future<Either<Failure, List<LocationDetailsEntity>>>
      getDataSharedPreferences();
  Future<Either<Failure, void>> setDataSharedPreferences(
      List<LocationDetailsEntity> addressEntity);
  Future<Either<Failure, void>> clearDataSharedPreferences();
}
