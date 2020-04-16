import 'package:flutter/material.dart';
import 'package:movieapp/pages/movie_grid/movie_grid_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MovieGridPage.create(context);
  }
}
