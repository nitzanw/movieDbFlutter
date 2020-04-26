import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';

abstract class UiEvent {
  final BuildContext context;

  UiEvent(this.context);
}

class DetailedMovieClickEvent extends UiEvent {
  final Movie movie;

  DetailedMovieClickEvent({BuildContext context, this.movie}) : super(context);

}

class MoreClickEvent extends UiEvent {
  final String apiName;

  MoreClickEvent({BuildContext context, this.apiName}) : super(context);

}
