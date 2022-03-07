import 'package:search_cep_project/app/core/utils/app_strings.dart';

class SearchCepEndpoint {
  static String viacep(String cep) => 'https://viacep.com.br/ws/$cep/json/';

  static String maps(String place) {
    String key = AppStrings.mapsApiKey;
    return 'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$place&language=pt-BR&key=$key';
  }
}
