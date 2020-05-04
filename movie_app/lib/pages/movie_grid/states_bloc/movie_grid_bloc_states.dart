import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/event/grid_event.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/pages/movie_grid/states_bloc/movie_grid_state.dart';
import 'package:movieapp/services/constants.dart' as Constants;
import 'package:movieapp/services/movie_db_api.dart';

class MovieGridBlocStates extends Bloc<GridEvent, MovieGridState> {
  MovieGridBlocStates(
      {@required this.movieDpApi, @required this.movieListType});

  final MovieDbApi movieDpApi;
  final Constants.MovieListType movieListType;


  @override
  void onTransition(Transition<GridEvent, MovieGridState> transition) {
    super.onTransition(transition);
    print(transition);
  }


  @override
  MovieGridState get initialState => MovieGridUninitialized();

  @override
  Stream<MovieGridState> mapEventToState(GridEvent event) async* {
    final currentState = state;
    if (event is FetchGridEvent && !_hasReachedMax(currentState)) {
      try {
        if (currentState is MovieGridUninitialized) {
          final movies = await _fetchMovies(1);
          yield MovieGridLoaded(movies: movies, hasReachedMax: false, page: 1);
          return;
        }
        if (currentState is MovieGridLoaded) {
          int nextPage = currentState.page + 1;
          final movies = await _fetchMovies(nextPage);
          yield movies.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : MovieGridLoaded(
                  movies: currentState.movies + movies,
                  hasReachedMax: false,
                  page: nextPage);
        }
      } catch (_) {
        yield MovieGridError();
      }
    }
  }

  bool _hasReachedMax(MovieGridState state) =>
      state is MovieGridLoaded && state.hasReachedMax;

  Future<List<Movie>> _fetchMovies(int page) async {
    try {
      MovieListResponse response =
          await movieDpApi.movieList(page, movieListType.apiName);
      return response.results;
    } catch (e) {
      rethrow;
    }
  }
}
