import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:search_cep_project/app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:search_cep_project/app/modules/home/domain/repositories/get_shared_repository.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/shared_preferences/get_address_shared.dart';

class GetAddressSharedPreferencesImpl implements GetAddressSharedPreferences {
  final GetSharedPreferencesRepository repository;

  GetAddressSharedPreferencesImpl({required this.repository});
  @override
  Future<Either<Failure, LocationDetailsEntity>> call() async {
    return await repository.call();
  }
}
