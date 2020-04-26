import 'package:flutter/material.dart';
import 'package:movieapp/pages/movie_grid/movie_list_bloc.dart';
import 'package:movieapp/pages/movie_grid/movie_list_model.dart';
import 'package:movieapp/pages/movie_home/horizontal_movie_list.dart';
import 'package:movieapp/services/movie_db_api.dart';
import 'package:provider/provider.dart';

class MovieHomePage extends StatelessWidget {
  const MovieHomePage({Key key, this.bloc}) : super(key: key);

  final MovieListBloc bloc;

  static Widget create(BuildContext context) {
    final MovieDbApi movieDpApi =
        Provider.of<MovieDbApi>(context, listen: false);
    return Provider<MovieListBloc>(
      create: (_) => MovieListBloc(movieDpApi: movieDpApi,),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<MovieListBloc>(
          builder: (context, bloc, _) => MovieHomePage(
                bloc: bloc,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc.movieList();
    return StreamBuilder<MovieListModel>(
      stream: bloc.modelStream,
      initialData: MovieListModel(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text("TMDB"),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                HorizontalMovieList(
                  movieListModel: snapshot.data,
                  eventDispatcher: bloc.eventDispatcher,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
