import 'package:flutter/foundation.dart';
import 'package:movieapp/models/detailed_movie.dart';
import 'package:movieapp/models/movie.dart';

class DetailedMovieModel with ChangeNotifier {
  DetailedMovieModel({this.detailedMovie, this.movie, this.isLoading});

  Movie movie;
  DetailedMovie detailedMovie;
  bool isLoading;

  void updateWith({Movie movie, DetailedMovie detailedMovie, bool isLoading}) {
    this.detailedMovie = detailedMovie ?? this.detailedMovie;
    this.movie = movie ?? this.movie;
    this.isLoading = isLoading ?? this.isLoading;
    notifyListeners();
  }

  void _loadDetailedMovie(
      Future<DetailedMovie> Function(int movieId) getDetailedMovie) async {
    try {
      updateWith(isLoading: true);
      DetailedMovie detailedMovie =
      await getDetailedMovie(movie.id);
      print(detailedMovie);
      updateWith(detailedMovie: detailedMovie);
    } catch (e) {
      rethrow;
    } finally {
      updateWith(isLoading: false);
    }
  }

  void getDetailedMovie() async => _loadDetailedMovie(movieDpApi.detailedMovie);

}
