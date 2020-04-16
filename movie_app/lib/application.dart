import 'package:flutter/material.dart';
import 'package:movieapp/pages/landing_page.dart';
import 'package:movieapp/pages/movie_grid/movie_grid_page.dart';
import 'package:movieapp/services/dio_movie_db_api.dart';
import 'package:provider/provider.dart';

import 'services/movie_db_api.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<MovieDbApi>(
      create: (_) => DioMovieDbApi(),
      child: MaterialApp(
        title: "Movie app",
        theme: ThemeData(
          primarySwatch: Colors.amber
        ),
        home: LandingPage()
      ),
    );
  }
}

