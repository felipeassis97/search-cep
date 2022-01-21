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

  final _$searchCepAsyncAction = AsyncAction('_HomeStoreBase.searchCep');

  @override
  Future<void> searchCep(String cep) {
    return _$searchCepAsyncAction.run(() => super.searchCep(cep));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
dataAddressByCep: ${dataAddressByCep}
    ''';
  }
}
