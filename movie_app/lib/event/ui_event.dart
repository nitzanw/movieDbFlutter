import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/services/constants.dart';

abstract class UiEvent {
  final BuildContext context;

  UiEvent(this.context);
}

class DetailedMovieClickEvent extends UiEvent {
  final Movie movie;

  DetailedMovieClickEvent({BuildContext context, this.movie}) : super(context);

}

class MoreClickEvent extends UiEvent {
  final MovieListType movieListType;

  MoreClickEvent({BuildContext context, this.movieListType}) : super(context);

}
