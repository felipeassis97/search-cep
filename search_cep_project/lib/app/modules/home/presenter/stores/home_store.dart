import 'package:mobx/mobx.dart';
import 'package:search_cep_project/app/core/errors/failures.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/search_Address_by_cep.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final SearchLocationByCep searchCepUsecase;
  _HomeStoreBase({required this.searchCepUsecase});

  @observable
  bool isLoading = false;

  @observable
  bool requestError = false;

  @observable
  LocationDetailsEntity? dataAddressByCep;

  @action
  Future<void> searchCep(String cep) async {
    requestError = false;

    isLoading = true;
    final result = await searchCepUsecase.call(cep);
    isLoading = false;

    result.fold(
      (failure) {
        if (failure == ServerFailure()) {
          requestError = true;
        }
        //isLoading = false;
        requestError = true;
      },
      (dataAddress) {
        dataAddressByCep = dataAddress;
      },
    );
  }
}
