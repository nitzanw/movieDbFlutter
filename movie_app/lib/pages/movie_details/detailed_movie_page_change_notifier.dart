import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/pages/movie_details/detailed_movie_model_change_notifier.dart';
import 'package:movieapp/services/movie_db_api.dart';
import 'package:provider/provider.dart';

class DetailedMoviePageChangeNotifier extends StatelessWidget {
  const DetailedMoviePageChangeNotifier({Key key, this.model})
      : super(key: key);
  final DetailedMovieModelChangeNotifier model;

  static Widget create(BuildContext context, Movie movie) {
    final MovieDbApi movieDpApi =
        Provider.of<MovieDbApi>(context, listen: false);
    return ChangeNotifierProvider<DetailedMovieModelChangeNotifier>(
      create: (_) => DetailedMovieModelChangeNotifier(
        movieDpApi: movieDpApi,
        movie: movie,
      ),
      child: Consumer<DetailedMovieModelChangeNotifier>(
        builder: (context, model, __) => DetailedMoviePageChangeNotifier(model : model)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(model.movie.title),
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(context),
      ),
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.2;
    return [
      model.isLoading ? _buildSpinner() :_buildRow(height),
      model.isLoading ? _buildSpinner() :_buildSubSection(),
    ];
  }

  Widget _buildSpinner() {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 3.0,
      ),
    );
  }

  Row _buildRow(double height) {
    var image_url = 'https://image.tmdb.org/t/p/w500/';
    var asset_url = 'images/movie_icon.png';

    return Row(
      children: <Widget>[
        Expanded(
            child: FadeInImage.assetNetwork(
          placeholder: asset_url,
          image: model.detailedMovie == null ? "" : image_url + model.detailedMovie.posterPath,
          fit: BoxFit.cover,
        )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 8.0,
                  ),
                  _textWidget("Budget: USD ${model.detailedMovie.budget}"),
                  SizedBox(
                    height: 8.0,
                  ),
                  _textWidget("Release: ${model.detailedMovie.releaseDate}"),
                  SizedBox(
                    height: 8.0,
                  ),
                  _textWidget("Runtime ${model.detailedMovie.runtime} min"),
                  SizedBox(
                    height: 8.0,
                  ),
                  _textWidget(
                      "Vote average: ${model.detailedMovie.voteAverage}/10"),
                  SizedBox(
                    height: 8.0,
                  ),
                  _textWidget("Status : ${model.detailedMovie.status}")
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _textWidget(String string) {
    return Text(
      string,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 12),
    );
  }

  Widget _buildSubSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Divider(
          color: Colors.amber,
        ),
        Text(
          "Overview",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          model.detailedMovie.overview ?? null,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 14),
        )
      ],
    );
  }
}
