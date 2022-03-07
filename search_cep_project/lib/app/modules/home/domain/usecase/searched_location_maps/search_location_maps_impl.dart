import 'package:search_cep_project/app/modules/home/domain/entities/location_maps_entity.dart';
import 'package:search_cep_project/app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:search_cep_project/app/modules/home/domain/repositories/search_location_maps_repository.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/searched_location_maps/search_location_maps.dart';

class SearchLocationMapsUsecaseImpl implements SearchLocationMapsUsecase {
  final SearchLocationMapsRepository repository;

  SearchLocationMapsUsecaseImpl(this.repository);

  @override
  Future<Either<Failure, List<LocationMapsEntity>>> call(String place) async {
    return await repository.call(place);
  }
}
