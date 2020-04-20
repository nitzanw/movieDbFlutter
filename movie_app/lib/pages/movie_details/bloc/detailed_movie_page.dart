import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movieapp/models/detailed_movie.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/pages/movie_details/bloc/detailed_movie_bloc.dart';
import 'package:movieapp/pages/movie_details/bloc/detailed_movie_model.dart';
import 'package:movieapp/pages/movie_details/video_section/video_section.dart';
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
          child: Column(
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
    return [
      model.isLoading ? _buildSpinner() : _buildRow(model),
      model.isLoading ? _buildSpinner() : _buildSubSection(model),
      model.isLoading ? _buildSpinner() : _buildCastSubSection(model),
      model.isLoading ? _buildSpinner() : _buildVideoSubSection(model),
      SizedBox(
        height: 20,
      )
    ];
  }

  Widget _buildRow(DetailedMovieModel model) {
    return Container(
      height: 280,
      child: Row(
        children: <Widget>[
          Expanded(
              child: FadeInImage.assetNetwork(
            placeholder: Constants.ASSET_URL,
            image: Constants.IMAGE_URL + model.detailedMovie.posterPath ?? null,
            fit: BoxFit.cover,
          )),
          Expanded(
            child: Container(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 12.0,
                      ),
                      Expanded(
                          child: _textWidget(
                              "Budget: USD ${model.detailedMovie.budget}")),
                      Expanded(
                          child: _textWidget(
                              "Release: ${model.detailedMovie.releaseDate}")),
                      Expanded(
                          child: _textWidget(
                              "Runtime ${model.detailedMovie.runtime} min")),
                      Expanded(
                        child: _textWidget(
                            "Vote average: ${model.detailedMovie.voteAverage}/10"),
                      ),
                      Expanded(
                          child: _textWidget(
                              "Status : ${model.detailedMovie.status}"))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
          height: 210,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: model.detailedMovie.credits.cast.length,
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                    width: 8,
                  ),
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
                        Expanded(
                            child: Text(
                                model.detailedMovie.credits.cast[index].name)),
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

  Widget _buildVideoSubSection(DetailedMovieModel model) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Divider(
            color: Colors.amber,
          ),
          Text(
            "Videos",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            height: 178,
            child: model.isLoading ? _buildSpinner() : VideoSection(videos : model.detailedMovie.videos, key: UniqueKey(),),
          ),
        ]);
  }
}
