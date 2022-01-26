import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:search_cep_project/app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:search_cep_project/app/modules/home/domain/repositories/set_shared_repository.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/shared_preferences/set_address_shared.dart';

class SetAddressSharedPreferencesImpl implements SetAddressSharedPreferences {
  final SetSharedRepository repository;

  SetAddressSharedPreferencesImpl({required this.repository});
  @override
  Future<Either<Failure, void>> call(
      LocationDetailsEntity addressEntity) async {
    return await repository.call(addressEntity);
  }
}
