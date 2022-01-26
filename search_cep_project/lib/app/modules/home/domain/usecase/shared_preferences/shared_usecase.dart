import 'package:dartz/dartz.dart';
import 'package:search_cep_project/app/core/errors/failures.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';

abstract class SharedPreferencesUsecase {
  Future<Either<Failure, LocationDetailsEntity>> getDataSharedPreferences();

  Future<Either<Failure, void>> setDataSharedPreferences(
      LocationDetailsEntity addressEntity);

  Future<Either<Failure, void>> clearDataSharedPreferences();
}
