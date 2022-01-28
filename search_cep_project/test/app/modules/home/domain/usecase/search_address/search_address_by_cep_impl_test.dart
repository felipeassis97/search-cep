import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_cep_project/app/core/errors/failures.dart';
import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';
import 'package:search_cep_project/app/modules/home/domain/repositories/location_details_repository.dart';
import 'package:search_cep_project/app/modules/home/domain/usecase/search_address/search_address_by_cep_impl.dart';

class MockLocationDetailsRepository extends Mock
    implements LocationDetailsRepository {}

void main() {
  late SearchAdressByCepUsecaseImpl searchAddressByCep;
  late LocationDetailsRepository mockRepository;

  String validCep = '91520610';

  const addressEntity = LocationDetailsEntity(
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

  setUpAll(() {
    mockRepository = MockLocationDetailsRepository();
    searchAddressByCep =
        SearchAdressByCepUsecaseImpl(repository: mockRepository);
  });

  test('should get location details Entity for a given String for a repository',
      () async {
    //Arrange
    when(mockRepository).calls(#getLocation).thenAnswer((_) async =>
        const Right<Failure, LocationDetailsEntity>(addressEntity));
    //Act
    final result = await searchAddressByCep.call(validCep);
    //Assert
    verify(mockRepository);
    expect(result, isA<Right>());
  });
  test('should return failure when an error occurs', () async {
    //Arrange
    when(mockRepository).calls(#getLocation).thenAnswer(
        (_) async => Left<Failure, LocationDetailsEntity>(ServerFailure()));
    //Act
    final result = await searchAddressByCep.call(validCep);
    //Assert
    verify(mockRepository);
    expect(result, isA<Left>());
  });
}
