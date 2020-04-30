import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/event/ui_event.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/pages/movie_details/bloc/detailed_movie_page.dart';
import 'package:movieapp/pages/movie_grid/movie_grid_page.dart';
import 'package:movieapp/pages/movie_grid/movie_grid_model.dart';
import 'package:movieapp/services/movie_db_api.dart';
import 'package:movieapp/services/constants.dart' as Constants;

class MovieGridBloc {
  MovieGridBloc({@required this.movieDpApi, @required this.movieListType});
  final MovieDbApi movieDpApi;
  final Constants.MovieListType movieListType;

  final StreamController<MovieGridModel> _loadingMoviesController =
  StreamController<MovieGridModel>();

  Stream<MovieGridModel> get modelStream => _loadingMoviesController.stream;
  MovieGridModel _model = MovieGridModel();

  void dispose() {
    _loadingMoviesController.close();
  }

  void updateWith({List<Movie> movieList, bool isLoading}) {
    _model = _model.copyWith(movieList: movieList, isLoading: isLoading);
    _loadingMoviesController.add(_model);
  }

  void _loadMovieList(Future<MovieListResponse> Function(int,String) getMovieList) async {
    try {
      updateWith(isLoading: true);
      MovieListResponse response = await getMovieList(1, movieListType.apiName);
      updateWith(movieList: response.results);
    } catch (e) {
      rethrow;
    } finally {
      updateWith(isLoading: false);
    }
  }

  void movieList() async => _loadMovieList(movieDpApi.movieList);

  eventDispatcher(UiEvent event) {

    if(event is DetailedMovieClickEvent){
      Navigator.of(event.context).push(
        MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (context) => DetailedMoviePage.create(context, event.movie),
        ),
      );
    }
    else if(event is MoreClickEvent){
      Navigator.of(event.context).push(
        MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (context) => MovieGridPage.create(context, event.movieListType),
        ),
      );
    }
  }
}
