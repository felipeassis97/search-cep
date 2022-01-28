import 'package:search_cep_project/app/core/client/search_cep_api_response.dart';

abstract class ISearchCepClient {
  Future<SearchCepApiResponse> get(String path,
      {Map<String, String>? headers, Map<String, dynamic>? query});
}
