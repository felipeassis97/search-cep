import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/search_address/search_address_by_cep.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/searched_location_maps/search_location_maps_impl.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/shared_preferences/shared_usecase.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final SearchLocationByCep usecaseSearchCep;
  final SharedPreferencesUsecase usecaseSharedPreferences;
  final SearchLocationMapsUsecaseImpl usecaseMaps;
  _HomeStoreBase(
      {required this.usecaseSearchCep,
      required this.usecaseSharedPreferences,
      required this.usecaseMaps});

  @observable
  bool isLoading = false;

  @observable
  bool requestError = false;

  @observable
  LocationDetailsEntity? dataAddressByCep;

  @observable
  List<LocationDetailsEntity> setDataAddressShared = [];

  @observable
  List<LocationDetailsEntity> currentDataAddressShared = [];

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

        String place =
            "${dataAddress.logradouro}, ${dataAddress.bairro}, ${dataAddress.localidade}";

        await getLocationByMaps(place);
      },
    );
    isLoading = false;
  }

  @action
  Future<void> getLocationByMaps(String place) async {
    final result = await usecaseMaps.call(place);
    result.fold(
      (failure) async {
        requestError = true;
      },
      (dataMaps) {
        setLatitude(dataMaps.first.geometry!.location!.lat!);
        setLongitude(dataMaps.first.geometry!.location!.lng!);
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
        currentDataAddressShared = addressShared;
      },
    );
    isLoading = false;
  }

  @action
  Future<void> clearSharedPreferences() async {
    final result = await usecaseSharedPreferences.clearDataSharedPreferences();
    result.fold(
      (failure) async {
        requestError = true;
      },
      (addressShared) async {
        currentDataAddressShared = [];
      },
    );
    isLoading = false;
  }

  Future<Position> actualPosition() async {
    LocationPermission? permission;
    bool isActive = await Geolocator.isLocationServiceEnabled();
    !isActive ? "Habilite a localização" : null;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      //Necessario ir até as configurações para habilitar
    }
    return await Geolocator.getCurrentPosition();
  }

  @observable
  double latitude = 0.0;
  @action
  void setLatitude(double value) => latitude = value;

  @observable
  double longitude = 0.0;
  @action
  void setLongitude(double value) => longitude = value;

  Future<void> getUserPosition() async {
    final position = await actualPosition();
    setLatitude(position.latitude);
    setLongitude(position.longitude);
  }
}
