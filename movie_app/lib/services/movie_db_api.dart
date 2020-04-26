import 'package:movieapp/models/detailed_movie.dart';
import 'package:movieapp/models/movie.dart';

abstract class MovieDbApi{

  Future<MovieListResponse> movieList({int pageNumber, String apiName});
  Future<DetailedMovie> detailedMovie(int movieId);



}