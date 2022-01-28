import 'package:dio/dio.dart' as dio;
import 'package:equatable/equatable.dart';

class SearchCepApiResponse extends Equatable {
  final int? statusCode;
  final dynamic data;

  const SearchCepApiResponse({required this.statusCode, required this.data});

  factory SearchCepApiResponse.fromDioResponse(dio.Response response) {
    return SearchCepApiResponse(
        data: response.data, statusCode: response.statusCode);
  }

  @override
  List<Object?> get props => [statusCode, data];
}
