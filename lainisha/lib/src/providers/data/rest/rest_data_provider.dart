import 'package:dio/dio.dart';
import 'package:lainisha/lainisha.dart';

/// A concrete implementation of [DataProvider] using the Dio package for
/// making HTTP requests.
/// 
/// This class provides methods to interact with RESTful APIs, allowing
/// for fetching lists, single items, creating, updating, and deleting
/// resources.
class RestDataProvider implements DataProvider {
  /// Creates a [RestDataProvider] with the given [baseUrl].
  ///
  /// [baseUrl] is the base URL for the API.
  RestDataProvider(this.baseUrl) : dio = Dio();

  /// The base URL for the API.
  final String baseUrl;

  /// The Dio instance used for making HTTP requests.
  final Dio dio;

  @override
  Future<List<T>> fetchList<T>(
    String resource, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await dio.get<dynamic>(
        '$baseUrl/$resource',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      if (response.statusCode == 200 && response.data is List) {
        return List<T>.from(response.data as List);
      } else {
        throw Exception('Failed to load list data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Future<T> fetchOne<T>(String resource, String id) async {
    try {
      final response = await dio.get<dynamic>('$baseUrl/$resource/$id');
      if (response.statusCode == 200) {
        return response.data as T;
      } else {
        throw Exception('Failed to load single item data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Future<T> create<T>(String resource, Map<String, dynamic> data) async {
    try {
      final response =
          await dio.post<dynamic>('$baseUrl/$resource', data: data);
      if (response.statusCode == 201) {
        return response.data as T;
      } else {
        throw Exception('Failed to create item');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Future<T> update<T>(
    String resource,
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response =
          await dio.put<dynamic>('$baseUrl/$resource/$id', data: data);
      if (response.statusCode == 200) {
        return response.data as T;
      } else {
        throw Exception('Failed to update item');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Future<void> delete(String resource, String id) async {
    try {
      final response = await dio.delete<dynamic>('$baseUrl/$resource/$id');
      if (response.statusCode != 204) {
        throw Exception('Failed to delete item');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
