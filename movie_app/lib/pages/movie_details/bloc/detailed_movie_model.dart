import 'package:flutter/cupertino.dart';
import 'package:movieapp/models/detailed_movie.dart';
import 'package:movieapp/models/movie.dart';

class DetailedMovieModel {
  DetailedMovieModel({this.detailedMovie, this.isLoading = true});

  final DetailedMovie detailedMovie;
  final bool isLoading;

  DetailedMovieModel copyWith(
      {DetailedMovie detailedMovie, bool isLoading}) {
    return DetailedMovieModel(
        detailedMovie: detailedMovie ?? this.detailedMovie,
        isLoading: isLoading ?? this.isLoading);
  }
}
