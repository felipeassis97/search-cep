import 'package:mobx/mobx.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/search_address/search_address_by_cep.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/shared_preferences/shared_usecase.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final SearchLocationByCep usecaseSearchCep;
  final SharedPreferencesUsecase usecaseSharedPreferences;
  _HomeStoreBase(
      {required this.usecaseSearchCep, required this.usecaseSharedPreferences});

  @observable
  bool isLoading = false;

  @observable
  bool requestError = false;

  @observable
  LocationDetailsEntity? dataAddressByCep;

  @observable
  List<LocationDetailsEntity> setDataAddressShared = [];

  @observable
  List<LocationDetailsEntity> getDataAddressShared = [];

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
    final result = await usecaseSearchCep.call(cep);
    await loadingDuration();
    result.fold(
      (failure) async {
        requestError = true;
      },
      (dataAddress) async {
        dataAddressByCep = dataAddress;
      },
    );
    isLoading = false;
  }

  @action
  Future<void> setSharedPreferences(
      List<LocationDetailsEntity> dataAddress) async {
    final result =
        await usecaseSharedPreferences.setDataSharedPreferences(dataAddress);

    result.fold(
      (failure) async {
        requestError = true;
      },
      (_) {},
    );
    isLoading = false;
  }

  @action
  Future<void> getSharedPreferences() async {
    final result = await usecaseSharedPreferences.getDataSharedPreferences();

    result.fold(
      (failure) async {
        requestError = true;
      },
      (addressShared) async {
        getDataAddressShared = addressShared;
      },
    );
    isLoading = false;
  }
}
