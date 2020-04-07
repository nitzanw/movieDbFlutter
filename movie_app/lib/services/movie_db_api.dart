import 'package:movieapp/models/movie.dart';

abstract class MovieDbApi{

  Future<MovieListResponse> movieList();

}