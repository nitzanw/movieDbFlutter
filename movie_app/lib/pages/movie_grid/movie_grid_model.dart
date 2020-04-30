import 'package:movieapp/models/movie.dart';

class MovieGridModel {
  MovieGridModel({this.movieList = const [], this.isLoading = true});

  final List<Movie> movieList;

  final bool isLoading;

  MovieGridModel copyWith({List<Movie> movieList, bool isLoading}) {
    return MovieGridModel(
        movieList: movieList ?? this.movieList,
        isLoading: isLoading ?? this.isLoading);
  }
}
