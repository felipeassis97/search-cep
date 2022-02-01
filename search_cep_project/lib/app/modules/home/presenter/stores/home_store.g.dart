// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStoreBase, Store {
  final _$isLoadingAtom = Atom(name: '_HomeStoreBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$requestErrorAtom = Atom(name: '_HomeStoreBase.requestError');

  @override
  bool get requestError {
    _$requestErrorAtom.reportRead();
    return super.requestError;
  }

  @override
  set requestError(bool value) {
    _$requestErrorAtom.reportWrite(value, super.requestError, () {
      super.requestError = value;
    });
  }

  final _$dataAddressByCepAtom = Atom(name: '_HomeStoreBase.dataAddressByCep');

  @override
  LocationDetailsEntity? get dataAddressByCep {
    _$dataAddressByCepAtom.reportRead();
    return super.dataAddressByCep;
  }

  @override
  set dataAddressByCep(LocationDetailsEntity? value) {
    _$dataAddressByCepAtom.reportWrite(value, super.dataAddressByCep, () {
      super.dataAddressByCep = value;
    });
  }

  final _$setDataAddressSharedAtom =
      Atom(name: '_HomeStoreBase.setDataAddressShared');

  @override
  List<LocationDetailsEntity> get setDataAddressShared {
    _$setDataAddressSharedAtom.reportRead();
    return super.setDataAddressShared;
  }

  @override
  set setDataAddressShared(List<LocationDetailsEntity> value) {
    _$setDataAddressSharedAtom.reportWrite(value, super.setDataAddressShared,
        () {
      super.setDataAddressShared = value;
    });
  }

  final _$currentDataAddressSharedAtom =
      Atom(name: '_HomeStoreBase.currentDataAddressShared');

  @override
  List<LocationDetailsEntity> get currentDataAddressShared {
    _$currentDataAddressSharedAtom.reportRead();
    return super.currentDataAddressShared;
  }

  @override
  set currentDataAddressShared(List<LocationDetailsEntity> value) {
    _$currentDataAddressSharedAtom
        .reportWrite(value, super.currentDataAddressShared, () {
      super.currentDataAddressShared = value;
    });
  }

  final _$loadingDurationAsyncAction =
      AsyncAction('_HomeStoreBase.loadingDuration');

  @override
  Future<void> loadingDuration() {
    return _$loadingDurationAsyncAction.run(() => super.loadingDuration());
  }

  final _$searchCepAsyncAction = AsyncAction('_HomeStoreBase.searchCep');

  @override
  Future<void> searchCep(String cep) {
    return _$searchCepAsyncAction.run(() => super.searchCep(cep));
  }

  final _$setSharedPreferencesAsyncAction =
      AsyncAction('_HomeStoreBase.setSharedPreferences');

  @override
  Future<void> setSharedPreferences(List<LocationDetailsEntity> dataAddress) {
    return _$setSharedPreferencesAsyncAction
        .run(() => super.setSharedPreferences(dataAddress));
  }

  final _$getSharedPreferencesAsyncAction =
      AsyncAction('_HomeStoreBase.getSharedPreferences');

  @override
  Future<void> getSharedPreferences() {
    return _$getSharedPreferencesAsyncAction
        .run(() => super.getSharedPreferences());
  }

  final _$clearSharedPreferencesAsyncAction =
      AsyncAction('_HomeStoreBase.clearSharedPreferences');

  @override
  Future<void> clearSharedPreferences() {
    return _$clearSharedPreferencesAsyncAction
        .run(() => super.clearSharedPreferences());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
requestError: ${requestError},
dataAddressByCep: ${dataAddressByCep},
setDataAddressShared: ${setDataAddressShared},
currentDataAddressShared: ${currentDataAddressShared}
    ''';
  }
}
