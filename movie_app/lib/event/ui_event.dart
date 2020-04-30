import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/services/constants.dart';

abstract class UiEvent extends Equatable{
  final BuildContext context;

  UiEvent(this.context);
}

class DetailedMovieClickEvent extends UiEvent {
  final Movie movie;

  DetailedMovieClickEvent({BuildContext context, this.movie}) : super(context);

  @override
  List<Object> get props => [this.movie];

  @override
  String toString() => 'ClickMovie';
}

class MoreClickEvent extends UiEvent {
  final MovieListType movieListType;

  MoreClickEvent({BuildContext context, this.movieListType}) : super(context);

  @override
  List<Object> get props => [movieListType];

  @override
  String toString() => 'More';
}

class FetchMoreMovies extends UiEvent{
  FetchMoreMovies(BuildContext context) : super(context);

  @override
  List<Object> get props => null;

  @override
  String toString() => 'Fetch';
}
