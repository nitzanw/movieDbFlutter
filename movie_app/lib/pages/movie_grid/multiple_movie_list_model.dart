import 'package:movieapp/models/movie.dart';

class MultipleMovieListModel {
  MultipleMovieListModel(
      {this.topRatedMovieList = const [],
      this.nowPlayingMovieList = const [],
      this.popularMovieList = const [],
      this.upcomingMovieList = const [],
      this.isLoading = true});

  final List<Movie> topRatedMovieList;
  final List<Movie> nowPlayingMovieList;
  final List<Movie> popularMovieList;
  final List<Movie> upcomingMovieList;
  final bool isLoading;

  MultipleMovieListModel copyWith({
    List<Movie> topRatedMovieList,
    List<Movie> nowPlayingMovieList,
    List<Movie> popularMovieList,
    List<Movie> upcomingMovieList,
    bool isLoading}) {
    return MultipleMovieListModel(
        topRatedMovieList: topRatedMovieList ?? this.topRatedMovieList,
        nowPlayingMovieList: nowPlayingMovieList ?? this.nowPlayingMovieList,
        popularMovieList: popularMovieList ?? this.popularMovieList,
        upcomingMovieList: upcomingMovieList ?? this.upcomingMovieList,
        isLoading: isLoading ?? this.isLoading);
  }
}
