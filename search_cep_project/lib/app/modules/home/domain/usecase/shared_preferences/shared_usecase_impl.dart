import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:search_cep_project/app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:search_cep_project/app/modules/home/domain/repositories/shared_repository.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/shared_preferences/shared_usecase.dart';

class SharedPreferencesUsecaseImpl implements SharedPreferencesUsecase {
  final SharedPreferencesRepository repository;

  SharedPreferencesUsecaseImpl({required this.repository});
  @override
  Future<Either<Failure, List<LocationDetailsEntity>>>
      getDataSharedPreferences() async {
    return await repository.getDataSharedPreferences();
  }

  @override
  Future<Either<Failure, void>> setDataSharedPreferences(
      List<LocationDetailsEntity> addressEntity) async {
    return await repository.setDataSharedPreferences(addressEntity);
  }

  @override
  Future<Either<Failure, void>> clearDataSharedPreferences() async {
    return await repository.clearDataSharedPreferences();
  }
}
