// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/pages/detailed_page.dart';
import 'package:movieapp/services/movie_db_api.dart';
import 'package:provider/provider.dart';


class GridList extends StatelessWidget {
  const GridList({Key key}) : super(key: key);

  List<Movie> _photos(BuildContext context) {
    return [
      Movie(
        movieId: "1",
        assetName: 'images/movie_icon.png',
        title: "Movie 1",
        subtitle: "a great movie about bla",
      ),
      Movie(
        movieId: "1",
        assetName: 'images/movie_icon.png',
        title: "Movie 1",
        subtitle: "a great movie about bla",
      ),
      Movie(
        movieId: "1",
        assetName: 'images/movie_icon.png',
        title: "Movie 1",
        subtitle: "a great movie about bla",
      ),
      Movie(
        movieId: "1",
        assetName: 'images/movie_icon.png',
        title: "Movie 1",
        subtitle: "a great movie about bla",
      ),
      Movie(
        movieId: "1",
        assetName: 'images/movie_icon.png',
        title: "Movie 1",
        subtitle: "a great movie about bla",
      ),
      Movie(
        movieId: "1",
        assetName: 'images/movie_icon.png',
        title: "Movie 1",
        subtitle: "a great movie about bla",
      ),
      Movie(
        movieId: "1",
        assetName: 'images/movie_icon.png',
        title: "Movie 1",
        subtitle: "a great movie about bla",
      ),
      Movie(
        movieId: "1",
        assetName: 'images/movie_icon.png',
        title: "Movie 1",
        subtitle: "a great movie about bla",
      ),
      Movie(
        movieId: "1",
        assetName: 'images/movie_icon.png',
        title: "Movie 1",
        subtitle: "a great movie about bla",
      ),
      Movie(
        movieId: "1",
        assetName: 'images/movie_icon.png',
        title: "Movie 1",
        subtitle: "a great movie about bla",
      ),
      Movie(
        movieId: "1",
        assetName: 'images/movie_icon.png',
        title: "Movie 1",
        subtitle: "a great movie about bla",
      ),
      Movie(
        movieId: "1",
        assetName: 'images/movie_icon.png',
        title: "Movie 1",
        subtitle: "a great movie about bla",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("This is a grid!"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        childAspectRatio: 1,
        children: _photos(context).map<Widget>((movie) {
          return _GridMovieItem(
            movie: movie,
          );
        }).toList(),
      ),
    );
  }
}


/// Allow the text size to shrink to fit in the space
class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: Text(text),
    );
  }
}

class _GridMovieItem extends StatelessWidget {
  _GridMovieItem({
    Key key,
    @required this.movie,
  }) : super(key: key);

  final Movie movie;

  Future<void> _getMovieList(BuildContext context) async{
    try {
      final MovieDbApi movieDpApi = Provider.of<MovieDbApi>(context, listen: false);
      await movieDpApi.movieList();
    } on Exception catch (e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => _getMovieList(context),
      child: GridTile(
        footer: Material(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridTileBar(
            backgroundColor: Colors.black45,
            title: _GridTitleText(movie.title),
            subtitle: _GridTitleText(movie.subtitle),
          ),
        ),
        child: Material(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            movie.assetName,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  _navigateToDetailedPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => DetailedPage(),
      ),
    );
  }
}

