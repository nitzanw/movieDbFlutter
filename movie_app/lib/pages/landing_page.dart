import 'package:flutter/material.dart';
import 'package:movieapp/pages/movie_list_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MovieListPage.create(context);
  }
}
