import 'package:mobx/mobx.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/search_address/search_address_by_cep.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/shared_preferences/get_address_shared.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/shared_preferences/set_address_shared.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final SearchLocationByCep usecase;
  final SetAddressSharedPreferences usecaseSetSharedPreferences;
  final GetAddressSharedPreferences usecaseGetSharedPreferences;
  _HomeStoreBase(
      {required this.usecase,
      required this.usecaseSetSharedPreferences,
      required this.usecaseGetSharedPreferences});

  @observable
  bool isLoading = false;

  @observable
  bool requestError = false;

  @observable
  LocationDetailsEntity? dataAddressByCep;

  @observable
  List<LocationDetailsEntity> dataAddressShared = [];

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
      (dataAddress) async {
        dataAddressByCep = dataAddress;
        await setSharedPreferences(dataAddress);
      },
    );
    isLoading = false;
  }

  @action
  Future<void> setSharedPreferences(LocationDetailsEntity dataAddress) async {
    requestError = false;
    isLoading = true;
    final result = await usecaseSetSharedPreferences.call(dataAddress);
    await loadingDuration();
    result.fold(
      (failure) async {
        requestError = true;
      },
      (_) {
        print("Success");
      },
    );
    isLoading = false;
  }

  @action
  Future<void> getSharedPreferences() async {
    requestError = false;
    isLoading = true;
    final result = await usecaseGetSharedPreferences.call();
    await loadingDuration();
    result.fold(
      (failure) async {
        requestError = true;
      },
      (addressShared) async {
        dataAddressShared.add(addressShared);
        print("GET: $dataAddressShared");
      },
    );
    isLoading = false;
  }
}
