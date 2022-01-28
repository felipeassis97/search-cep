import 'package:dartz/dartz.dart';
import 'package:search_cep_project/app/core/errors/failures.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:search_cep_project/app/modules/home/domain/repositories/location_details_repository.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/search_address/search_address_by_cep.dart';

class SearchAdressByCepUsecaseImpl implements SearchLocationByCep {
  final LocationDetailsRepository repository;

  SearchAdressByCepUsecaseImpl({required this.repository});

  @override
  Future<Either<Failure, LocationDetailsEntity>> call(String cep) async {
    return await repository.getLocation(cep);
  }
}
