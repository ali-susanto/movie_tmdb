import 'package:dio/dio.dart';

import '../common/constant.dart';

class ApiService {
  final dio = Dio();

  Future<Response> getTopRatedMovies() async {
    final response = await dio.get('${Constant.baseUrl}/movie/top_rated',
        options:
            Options(headers: {'Authorization': 'bearer ${Constant.token}'}));
    return response;
  }

  Future<Response> getUpcomingMovies() async {
    final response = await dio.get('${Constant.baseUrl}/movie/upcoming',
        options:
            Options(headers: {'Authorization': 'bearer ${Constant.token}'}));
    return response;
  }

  Future<Response> getNowPlayingMovie() async {
    final response = await dio.get('${Constant.baseUrl}/movie/now_playing',
        options:
            Options(headers: {'Authorization': 'bearer ${Constant.token}'}));
    return response;
  }

  Future<Response> getPopularMovie() async {
    final response = await dio.get('${Constant.baseUrl}/movie/popular',
        options:
            Options(headers: {'Authorization': 'bearer ${Constant.token}'}));
    return response;
  }

  Future<Response> getDetailMovie({required int idMovie}) async {
    final respoonse = await dio.get("${Constant.baseUrl}/movie/$idMovie",
        options:
            Options(headers: {'Authorization': 'bearer ${Constant.token}'}));
    return respoonse;
  }

  Future<Response> getRecomendationMovie({required int idMovie}) async {
    final response = await dio.get(
        "${Constant.baseUrl}/movie/$idMovie/recommendations",
        options:
            Options(headers: {'Authorization': 'bearer ${Constant.token}'}));
    return response;
  }

  Future<Response> searchMovie({required String query}) async {
    final response = await dio.get("${Constant.baseUrl}/search/movie",
        queryParameters: {"api_key": Constant.apiKey, "query": query});
    return response;
  }
}
