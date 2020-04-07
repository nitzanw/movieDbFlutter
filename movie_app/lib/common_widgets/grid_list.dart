// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/pages/detailed_page.dart';
import 'package:movieapp/pages/movie_list_model.dart';
import 'package:movieapp/services/movie_db_api.dart';
import 'package:provider/provider.dart';

class GridList extends StatefulWidget {
  const GridList({this.movieListModel, Key key}) : super(key: key);
  final MovieListModel movieListModel;

  @override
  _GridListState createState() => _GridListState();
}

class _GridListState extends State<GridList> {
  List<Movie> _photos(BuildContext context) {
    return widget.movieListModel.movieList;
//    return [
//      Movie(
//        id: 1,
//        poster_path: 'images/movie_icon.png',
//        title: "Movie 1",
//        overview: "a great movie about bla",
//      ),
//      Movie(
//        id: 1,
//        poster_path: 'images/movie_icon.png',
//        title: "Movie 1",
//        overview: "a great movie about bla",
//      ),
//      Movie(
//        id: 1,
//        poster_path: 'images/movie_icon.png',
//        title: "Movie 1",
//        overview: "a great movie about bla",
//      ),
//      Movie(
//        id: 1,
//        poster_path: 'images/movie_icon.png',
//        title: "Movie 1",
//        overview: "a great movie about bla",
//      ),
//      Movie(
//        id: 1,
//        poster_path: 'images/movie_icon.png',
//        title: "Movie 1",
//        overview: "a great movie about bla",
//      ),
//      Movie(
//        id: 1,
//        poster_path: 'images/movie_icon.png',
//        title: "Movie 1",
//        overview: "a great movie about bla",
//      ),
//      Movie(
//        id: 1,
//        poster_path: 'images/movie_icon.png',
//        title: "Movie 1",
//        overview: "a great movie about bla",
//      ),
//      Movie(
//        id: 1,
//        poster_path: 'images/movie_icon.png',
//        title: "Movie 1",
//        overview: "a great movie about bla",
//      ),
//      Movie(
//        id: 1,
//        poster_path: 'images/movie_icon.png',
//        title: "Movie 1",
//        overview: "a great movie about bla",
//      ),
//      Movie(
//        id: 1,
//        poster_path: 'images/movie_icon.png',
//        title: "Movie 1",
//        overview: "a great movie about bla",
//      ),
//      Movie(
//        id: 1,
//        poster_path: 'images/movie_icon.png',
//        title: "Movie 1",
//        overview: "a great movie about bla",
//      ),
//      Movie(
//        id: 1,
//        poster_path: 'images/movie_icon.png',
//        title: "Movie 1",
//        overview: "a great movie about bla",
//      ),
//    ];
  }

  Widget _buildSpinner() {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 3.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("This is a grid!"),
      ),
      body: widget.movieListModel.isLoading
          ? _buildSpinner()
          : GridView.count(
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
    return Text(
      text,
      softWrap: true,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14.0,
      ),
    );
  }
}

class _GridMovieItem extends StatelessWidget {
  _GridMovieItem({
    Key key,
    @required this.movie,
  }) : super(key: key);

  final Movie movie;

  Future<void> _getMovieList(BuildContext context) async {
//    try {
//      final MovieDbApi movieDpApi =
//          Provider.of<MovieDbApi>(context, listen: false);
//      await movieDpApi.movieList();
//    } on Exception catch (e) {
//      print(e);
//    }
    print("click");
  }

  @override
  Widget build(BuildContext context) {
    var image_url = 'https://image.tmdb.org/t/p/w500/';
    var asset_url = 'images/movie_icon.png';

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
          ),
        ),
        child: Material(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          clipBehavior: Clip.antiAlias,
          child: FadeInImage.assetNetwork(
            placeholder: asset_url,
            image: image_url + movie.poster_path,
            fit: BoxFit.cover,
          ),
//          child: Image.asset(
//            movie.poster_path,
//            fit: BoxFit.cover,
//          ),
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
