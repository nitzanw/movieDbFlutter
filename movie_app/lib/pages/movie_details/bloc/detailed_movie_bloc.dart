import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:movieapp/models/detailed_movie.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/services/movie_db_api.dart';

import 'detailed_movie_model.dart';

class DetailedMovieBloc {
  DetailedMovieBloc({@required this.movieDpApi, @required this.movie}) {
    detailedMovie();
  }

  final MovieDbApi movieDpApi;
  final Movie movie;
  final StreamController<DetailedMovieModel> _controller =
      StreamController<DetailedMovieModel>();

  Stream<DetailedMovieModel> get modelStream => _controller.stream;
  DetailedMovieModel _model = DetailedMovieModel();

  void dispose() {
    _controller.close();
  }

  void updateWith({DetailedMovie detailedMovie, bool isLoading}) {
    _model.copyWith(
        detailedMovie: detailedMovie, isLoading: isLoading);
    _controller.add(_model);
  }

  Future<void> _loadDetailedMovie(
      Future<DetailedMovie> Function(int movieId) getDetailedMovie) async {
    try {
      updateWith(isLoading: true);
      DetailedMovie detailedMovie = await getDetailedMovie(movie.id);
      print(detailedMovie);
      updateWith(detailedMovie: detailedMovie, isLoading: false);
    } catch (e) {
      rethrow;
    }
  }

  void detailedMovie() async => _loadDetailedMovie(movieDpApi.detailedMovie);
}
