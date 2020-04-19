import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movieapp/models/detailed_movie.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/services/movie_db_api.dart';

class DioMovieDbApi implements MovieDbApi {
  final String apiKey = "3cfeb71f36d65a568c151c682f237cf8";
  final Dio _dio = Dio();

  DioMovieDbApi() {
    _dio.options.baseUrl = "https://api.themoviedb.org/3/";
  }

  @override
  Future<MovieListResponse> movieList() async {
    Response response =
        await _dio.get("/discover/movie", queryParameters: {"api_key": apiKey});
    Map<String, dynamic> json = jsonDecode(response.toString());
    MovieListResponse movieListResponse = MovieListResponse.fromJson(json);
    return movieListResponse;
  }

  @override
  Future<DetailedMovie> detailedMovie(int movieId) async {
    print("the movie id $movieId");
    Response response = await _dio.get("/movie/$movieId", queryParameters: {
      "api_key": apiKey,
      "append_to_response" : "credits",
    });
    Map<String, dynamic> json = jsonDecode(response.toString());
    print(json);
    DetailedMovie detailedMovie = DetailedMovie.fromJson(json);
    return detailedMovie;
  }
}
