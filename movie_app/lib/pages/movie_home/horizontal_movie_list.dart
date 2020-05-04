import 'package:flutter/material.dart';
import 'package:movieapp/event/nav_event.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/services/constants.dart' as Constants;

class HorizontalMovieList extends StatelessWidget {
  final List<Movie> movieList;
  final bool isLoading;
  final Function(NavEvent) eventDispatcher;
  final Constants.MovieListType movieListType;

  const HorizontalMovieList(
      {Key key,
      @required this.movieList,
      @required this.eventDispatcher,
      @required this.movieListType,
      @required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  movieListType.title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () => _navigateToMorePage(context, movieListType),
                child: Text(
                  "More",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(4),
          child: Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return isLoading
                    ? _buildSpinner()
                    : GestureDetector(
                        onTap: () =>
                            _navigateToDetailedPage(context, movieList[index]),
                        child: Container(
                          width: 150,
                          padding: EdgeInsets.all(4),
                          child: FadeInImage.assetNetwork(
                            placeholder: Constants.ASSET_URL,
                            image: Constants.IMAGE_URL +
                                movieList[index].poster_path,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
              },
              itemCount: movieList.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpinner() {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 3.0,
      ),
    );
  }

  _navigateToDetailedPage(BuildContext context, Movie movie) {
    eventDispatcher(DetailedMovieClickEvent(context: context, movie: movie));
  }

  _navigateToMorePage(
      BuildContext context, Constants.MovieListType movieListType) {
    eventDispatcher(MoreClickEvent(context: context, movieListType: movieListType));
  }
}
