import 'package:movieapp/models/movie.dart';

class MovieListModel {
  MovieListModel({this.movieList = const [], this.isLoading = true});

  final List<Movie> movieList;

  final bool isLoading;

  MovieListModel copyWith({List<Movie> movieList, bool isLoading}) {
    return MovieListModel(movieList: movieList ?? this.movieList, isLoading: isLoading ?? this.isLoading);
  }
}
