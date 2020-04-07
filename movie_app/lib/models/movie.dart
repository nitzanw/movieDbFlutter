import 'package:flutter/widgets.dart';

class Movie {
  int id;
  String poster_path;
  String title;
  String overview;

  Movie({
    @required this.id,
    @required this.title,
    this.poster_path,
    this.overview,
  });

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        overview = json['overview'],
        poster_path = json['poster_path'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'overview': overview,
        'poster_path': poster_path,
      };
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
