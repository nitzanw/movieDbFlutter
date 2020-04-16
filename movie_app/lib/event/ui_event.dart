import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';

abstract class UiEvent {
  final BuildContext context;

  UiEvent(this.context);
}

class GridClickEvent extends UiEvent {
  final Movie movie;

  GridClickEvent({BuildContext context, this.movie}) : super(context);

}
