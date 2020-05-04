import 'package:equatable/equatable.dart';
import 'package:movieapp/models/movie.dart';

abstract class MovieGridState extends Equatable {
  MovieGridState() : super();
  @override
  List<Object> get props => const [];
}
class MovieGridUninitialized extends MovieGridState {
  @override
  String toString() => 'MovieGridUninitialized';

}

class MovieGridError extends MovieGridState {
  @override
  String toString() => 'MovieGridError';
}

class MovieGridEmpty extends MovieGridState {
  @override
  String toString() => 'MovieGridEmpty';
}

class MovieGridLoaded extends MovieGridState {
  final List<Movie> movies;
  final bool hasReachedMax;
  final int page;


  MovieGridLoaded({
    this.movies,
    this.hasReachedMax,
    this.page
  }) : super();

  MovieGridLoaded copyWith({
    List<Movie> movies,
    bool hasReachedMax,
    int page
  }) {
    return MovieGridLoaded(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page
    );
  }

  List<Object> get props => [movies, hasReachedMax];

  @override
  String toString() =>
      'MovieGridLoaded { movies: ${movies.length}, hasReachedMax: $hasReachedMax , page : $page}';
}