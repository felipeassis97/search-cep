import 'package:dio/dio.dart';

class SearchCepClient {
  final Dio client;

  SearchCepClient({required this.client});

  Future<Response<dynamic>> get(String path,
      {Map<String, String> headers = const <String, String>{}}) async {
    final result = await client.get<dynamic>(path);

    return result;
  }
}
