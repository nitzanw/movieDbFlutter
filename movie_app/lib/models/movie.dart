import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String poster_path;
  final String overview;
  final String backdrop_path;

  Movie({
    @required this.id,
    @required this.title,
    this.poster_path,
    this.backdrop_path,
    this.overview,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json['title'],
        poster_path: json['poster_path'],
        overview: json['overview'],
        backdrop_path: json['backdrop_path']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'overview': overview,
        'poster_path': poster_path,
        'backdrop_path': backdrop_path,
      };

  @override
  List<Object> get props => [id, poster_path, title, overview, backdrop_path];
}

class MovieListResponse {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  MovieListResponse(
      {this.page, this.results, this.totalPages, this.totalResults});

  MovieListResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = new List<Movie>();
      json['results'].forEach((v) {
        results.add(new Movie.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

//  Map<String, dynamic> toJson() => {'page': page, 'results': results};
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}
