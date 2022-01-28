import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_cep_project/app/modules/home/data/datasource/search_cep/location_details_datasource.dart';
import 'package:search_cep_project/app/modules/home/data/model/location_details_model.dart';
import 'package:search_cep_project/app/modules/home/data/repositories/location_details_repository_impl.dart';

class MockLocationDetailsDatasource extends Mock
    implements LocationDetailsDatasource {}

void main() {
  late MockLocationDetailsDatasource mockDatasource;
  late LocationDetailsRepositoryImpl repository;

  String validCep = '91520610';

  const locationModel = LocationDetailsModel(
      cep: "91520-610",
      logradouro: "Rua Nove de Junho",
      complemento: "",
      bairro: "Vila São José",
      localidade: "Porto Alegre",
      uf: "RS",
      ibge: "4314902",
      gia: "",
      ddd: "51",
      siafi: "8801");

  setUp(() {
    mockDatasource = MockLocationDetailsDatasource();
    repository = LocationDetailsRepositoryImpl(datasource: mockDatasource);
  });

  test('Should return a model with details address', () async {
    when(mockDatasource)
        .calls(#getDetailsLocation)
        .thenAnswer((_) async => locationModel);

    final result = await repository.getLocation(validCep);

    expect(
        result,
        allOf([
          isA<Right>(),
          right(locationModel),
        ]));
  });
}
