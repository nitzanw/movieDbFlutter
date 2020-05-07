import 'package:flutter/material.dart';
import 'package:movieapp/event/interaction_event.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/services/movie_list_type.dart';

abstract class NavEvent extends InteractionEvent{
  final BuildContext context;

  NavEvent(this.context);
}

class DetailedMovieClickEvent extends NavEvent {
  final Movie movie;

  DetailedMovieClickEvent({BuildContext context, this.movie}) : super(context);

  @override
  List<Object> get props => [this.movie];

  @override
  String toString() => 'ClickMovie';
}

class MoreClickEvent extends NavEvent {
  final MovieListType movieListType;

  MoreClickEvent({BuildContext context, this.movieListType}) : super(context);

  @override
  List<Object> get props => [movieListType];

  @override
  String toString() => 'More';
}

class FetchMoreMovies extends NavEvent{
  FetchMoreMovies(BuildContext context) : super(context);

  @override
  List<Object> get props => null;

  @override
  String toString() => 'Fetch';
}
