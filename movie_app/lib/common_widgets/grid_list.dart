// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:movieapp/event/ui_event.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/pages/movie_grid/movie_list_model.dart';
import 'package:movieapp/services/constants.dart' as Constants;

class GridList extends StatelessWidget {
  const GridList({@required this.movieListModel, @required this.eventDispatcher, @required this.title, Key key})
      : super(key: key);
  final MovieListModel movieListModel;
  final Function(DetailedMovieClickEvent) eventDispatcher;
  final String title;

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
        title: Text(title),
      ),
      body: movieListModel.isLoading
          ? _buildSpinner()
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: movieListModel.movieList.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (_, index) {
                final Movie movie =  movieListModel.movieList[index];
                return GestureDetector(
                  onTap: ()=>_navigateToDetailedPage(context,movie),
                  child: _GridMovieItem(
                    movie: movie,
                  ),
                );
              },
            ),
    );
  }
  _navigateToDetailedPage(BuildContext context, Movie movie) {
    eventDispatcher(DetailedMovieClickEvent(context: context, movie: movie));
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

  @override
  Widget build(BuildContext context) {
    return GridTile(
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
          placeholder: Constants.ASSET_URL,
          image: Constants.IMAGE_URL + movie.poster_path,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
