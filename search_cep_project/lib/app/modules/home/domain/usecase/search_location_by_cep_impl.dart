import 'package:dartz/dartz.dart';
import 'package:search_cep_project/app/core/errors/failures.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:search_cep_project/app/modules/home/domain/repositories/location_details_repository.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/search_location_by_cep.dart';

class SearchLocationByCepImpl implements SearchLocationByCep {
  final LocationDetailsRepository detailsLocationRepository;

  SearchLocationByCepImpl(this.detailsLocationRepository);

  @override
  Future<Either<Failure, LocationDetailsEntity>> call(String cep) async {
    return await detailsLocationRepository.call(cep);
  }
}
