import 'package:flutter/material.dart';
import 'package:movieapp/event/interaction_event.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/services/constants.dart' as Constants;


abstract class GridEvent extends InteractionEvent {}

class FetchGridEvent extends GridEvent{
  FetchGridEvent();

  @override
  String toString() => 'Fetch';

  @override
  List<Object> get props => [];
}

class ClickMovieGridEvent extends GridEvent{
  final BuildContext context;
  final Movie movie;
  ClickMovieGridEvent({this.movie, this.context});

  @override
  String toString() => 'Click';

  @override
  List<Object> get props => [movie];
}