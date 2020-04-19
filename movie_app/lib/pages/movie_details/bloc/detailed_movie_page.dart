import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movieapp/models/detailed_movie.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/pages/movie_details/bloc/detailed_movie_bloc.dart';
import 'package:movieapp/pages/movie_details/bloc/detailed_movie_model.dart';
import 'package:movieapp/services/movie_db_api.dart';
import 'package:provider/provider.dart';
import 'package:movieapp/services/constants.dart' as Constants;

class DetailedMoviePage extends StatelessWidget {
  const DetailedMoviePage({
    Key key,
    this.bloc,
  }) : super(key: key);
  final DetailedMovieBloc bloc;

  static Widget create(BuildContext context, Movie movie) {
    final MovieDbApi movieDpApi =
        Provider.of<MovieDbApi>(context, listen: false);
    return Provider<DetailedMovieBloc>(
      create: (_) => DetailedMovieBloc(movieDpApi: movieDpApi, movie: movie),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<DetailedMovieBloc>(
          builder: (context, bloc, _) => DetailedMoviePage(
                bloc: bloc,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.modelStream,
      initialData: DetailedMovieModel(),
      builder: (context, snapshot) {
        final DetailedMovieModel model = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(bloc.movie.title),
          ),
          body: _buildContent(context, model),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, DetailedMovieModel model) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
//          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildChildren(context, model),
          ),
        ),
      ),
    );
  }

  Widget _buildSpinner() {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 3.0,
      ),
    );
  }

  List<Widget> _buildChildren(BuildContext context, DetailedMovieModel model) {
    final double height = MediaQuery.of(context).size.height * 0.2;
    return [
      model.isLoading ? _buildSpinner() : _buildRow(height, model),
      model.isLoading ? _buildSpinner() : _buildSubSection(model),
      model.isLoading ? _buildSpinner() : _buildCastSubSection(model),
      SizedBox(
        height: 20,
      )
    ];
  }

  Row _buildRow(double height, DetailedMovieModel model) {
    return Row(
      children: <Widget>[
        Expanded(
            child: FadeInImage.assetNetwork(
          placeholder: Constants.ASSET_URL,
          image: Constants.IMAGE_URL + model.detailedMovie.posterPath ?? null,
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

  Widget _buildSubSection(DetailedMovieModel model) {
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

  Widget _buildCastSubSection(DetailedMovieModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Divider(
          color: Colors.amber,
        ),
        Text(
          "Cast",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Container(
          height: 240,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: model.detailedMovie.credits.cast.length,
              separatorBuilder: (BuildContext context, int index) => SizedBox(width: 8,),
              itemBuilder: (BuildContext context, int index) => Center(
                    child: SizedBox(
                      width: 120,
                      child: Column(children: [
                        Card(
                          child: GestureDetector(
                            child: SizedBox(
                              height: 160,
                              child: FadeInImage.assetNetwork(
                                placeholder: Constants.ASSET_URL,
                                placeholderScale: 0.3,
                                image: _castImage(
                                    model.detailedMovie.credits.cast[index]),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Expanded(child: Text( model.detailedMovie.credits.cast[index].name)),
                      ]),
                    ),
                  )),
        ),
      ],
    );
  }

  String _castImage(Cast castMember) {
    if (castMember.profilePath == null) {
      return "";
    }
    return Constants.IMAGE_URL + castMember.profilePath;
  }
}
