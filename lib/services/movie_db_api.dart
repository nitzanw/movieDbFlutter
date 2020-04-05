import 'package:movieapp/models/movie.dart';

abstract class MovieDbApi{

  Future<List<Movie>> movieList();

}