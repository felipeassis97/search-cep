import 'package:search_cep_project/app/modules/home/domain/entities/location_details_entity.dart';

class LocationDetailsModel extends LocationDetailsEntity {
  const LocationDetailsModel(
      {required String cep,
      required String logradouro,
      required String complemento,
      required String bairro,
      required String localidade,
      required String uf,
      required String ibge,
      required String gia,
      required String ddd,
      required String siafi})
      : super(
            cep: cep,
            logradouro: logradouro,
            complemento: complemento,
            bairro: bairro,
            localidade: localidade,
            uf: uf,
            ibge: ibge,
            gia: gia,
            ddd: ddd,
            siafi: siafi);

  factory LocationDetailsModel.fromJson(Map<String, dynamic> json) =>
      LocationDetailsModel(
        cep: json['cep'],
        logradouro: json['logradouro'],
        complemento: json['complemento'],
        bairro: json['bairro'],
        localidade: json['localidade'],
        uf: json['uf'],
        ibge: json['ibge'],
        gia: json['gia'],
        ddd: json['ddd'],
        siafi: json['siafi'],
      );
}
