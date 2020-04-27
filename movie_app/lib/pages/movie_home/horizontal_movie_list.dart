import 'package:flutter/material.dart';
import 'package:movieapp/event/ui_event.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/pages/movie_grid/movie_list_model.dart';
import 'package:movieapp/services/constants.dart' as Constants;

class HorizontalMovieList extends StatelessWidget {
  final MovieListModel movieListModel;

  final Function(UiEvent) eventDispatcher;

  const HorizontalMovieList(
      {Key key, this.movieListModel, this.eventDispatcher})
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
                child: Text(Constants.apiNameToTitleMap["/movie/top_rated"],
                  textAlign: TextAlign.start,
                  style: TextStyle(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: ()=>_navigateToMorePage(context, "/movie/top_rated"),
                child: Text(
                  "More",
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
                return movieListModel.isLoading ? _buildSpinner() :
                GestureDetector(
                  onTap: () => _navigateToDetailedPage(
                      context, movieListModel.movieList[index]),
                  child: Container(
                    width: 150,
                    padding: EdgeInsets.all(4),
                    child: FadeInImage.assetNetwork(
                      placeholder: Constants.ASSET_URL,
                      image: Constants.IMAGE_URL +
                          movieListModel.movieList[index].poster_path,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              itemCount: movieListModel.movieList.length,
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

  _navigateToMorePage(BuildContext context, String apiName) {
    eventDispatcher(MoreClickEvent(context: context, apiName: apiName));
  }
}