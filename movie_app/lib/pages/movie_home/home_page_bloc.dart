import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/event/nav_event.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/pages/movie_details/bloc/detailed_movie_page.dart';
import 'package:movieapp/pages/movie_grid/movie_grid_page.dart';
import 'package:movieapp/pages/movie_grid/states_bloc/movie_grid_page_states.dart';
import 'package:movieapp/pages/movie_home/multiple_movie_list_model.dart';
import 'package:movieapp/services/constants.dart';
import 'package:movieapp/services/movie_db_api.dart';

class HomePageBloc {
  HomePageBloc({@required this.movieDpApi});

  final MovieDbApi movieDpApi;

  final StreamController<MultipleMovieListModel> _loadingMoviesController =
      StreamController<MultipleMovieListModel>();

  Stream<MultipleMovieListModel> get modelStream =>
      _loadingMoviesController.stream;
  MultipleMovieListModel _model = MultipleMovieListModel();

  void dispose() {
    _loadingMoviesController.close();
  }

  void updateWith({List<Movie> movieList, bool isLoading, MovieListType movieListType}) {
    switch (movieListType.runtimeType) {
      case Popular:
        {
          _model = _model.copyWith(
              isLoading: isLoading, popularMovieList: movieList);
        }
        break;

      case TopRated:
        {
          _model = _model.copyWith(
              isLoading: isLoading, topRatedMovieList: movieList);
        }
        break;
      case NowPlaying:
        {
          _model = _model.copyWith(
              isLoading: isLoading, nowPlayingMovieList: movieList);
        }
        break;
      case Upcoming:
        {
          _model = _model.copyWith(
              isLoading: isLoading, upcomingMovieList: movieList);
        }
        break;
    }
    _loadingMoviesController.add(_model);
  }

  void _loadMovieList(
      Future<MovieListResponse> Function(int, String) getMovieList,
      MovieListType movieListType) async {
    try {
      updateWith(isLoading: true);
      MovieListResponse response = await getMovieList(1, movieListType.apiName);
      updateWith(movieList: response.results, movieListType: movieListType, isLoading : false);
    } catch (e) {
      rethrow;
    } finally {
      updateWith(isLoading: false);
    }
  }

  void movieList(MovieListType movieListType) async =>
      _loadMovieList(movieDpApi.movieList, movieListType);

  eventDispatcher(NavEvent event) {
    if (event is DetailedMovieClickEvent) {
      Navigator.of(event.context).push(
        MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (context) => DetailedMoviePage.create(context, event.movie),
        ),
      );
    } else if (event is MoreClickEvent) {
      Navigator.of(event.context).push(
        MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (context) =>
              MovieGridPageStates.create(context, event.movieListType),
        ),
      );
    }
  }
}
