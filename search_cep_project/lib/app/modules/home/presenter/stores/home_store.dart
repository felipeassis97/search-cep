import 'package:mobx/mobx.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/search_address_by_cep.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final SearchLocationByCep usecase;
  _HomeStoreBase({required this.usecase});

  @observable
  bool isLoading = false;

  @observable
  bool requestError = false;

  @observable
  LocationDetailsEntity? dataAddressByCep;

  @action
  Future<void> loadingDuration() async {
    await Future.delayed(const Duration(seconds: 3), () {
      isLoading = false;
    });
  }

  @action
  Future<void> searchCep(String cep) async {
    requestError = false;

    isLoading = true;
    final result = await usecase.call(cep);
    await loadingDuration();

    result.fold(
      (failure) async {
        requestError = true;
      },
      (dataAddress) {
        dataAddressByCep = dataAddress;
      },
    );
    isLoading = false;
  }
}
