import 'package:search_cep_project/app/core/client/search_cep_api_response.dart';
import 'package:search_cep_project/app/core/client/serarch_cep_client_i.dart';
import 'package:dio/dio.dart' as dio;

class SearchCepClientImpl implements ISearchCepClient {
  final dio.Dio client;

  SearchCepClientImpl({required this.client});

  @override
  Future<SearchCepApiResponse> get(String path,
      {Map<String, String>? headers, Map<String, dynamic>? query}) async {
    final response = await client.get(path,
        queryParameters: query,
        options: dio.Options(
            headers: headers,
            validateStatus: (status) =>
                status != null && (status >= 200 && status <= 499)));

    return SearchCepApiResponse.fromDioResponse(response);
  }
}
