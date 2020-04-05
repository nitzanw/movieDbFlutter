import 'package:flutter/widgets.dart';

class Movie {
  Movie({
    @required this.movieId,
    this.assetName,
    @required this.title,
    this.subtitle,
  });

  final String movieId;
  final String assetName;
  final String title;
  final String subtitle;
}
