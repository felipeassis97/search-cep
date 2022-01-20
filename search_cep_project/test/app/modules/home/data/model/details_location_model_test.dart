import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:search_cep_project/app/modules/home/data/model/details_location_model.dart';
import '../../../../../fixtures/fixture_reader.dart';

void main() {
  const detailsLocationModel = DetailsLocationModel(
      cep: "90010-220",
      logradouro: "Avenida Senador Salgado Filho",
      complemento: "lado par",
      bairro: "Centro Histórico",
      localidade: "Porto Alegre",
      uf: "RS",
      ibge: "4314902",
      gia: "",
      ddd: "51",
      siafi: "8801");

  test('should create a model from json', () {
    // Arrange
    final serialized = fixture('details-address.json');
    final mapped = json.decode(serialized);
    // Act
    final result = DetailsLocationModel.fromJson(mapped);
    // Assert
    expect(result, detailsLocationModel);
  });
}
