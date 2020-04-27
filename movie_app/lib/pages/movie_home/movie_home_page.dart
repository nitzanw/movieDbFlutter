import 'package:flutter/material.dart';
import 'package:movieapp/pages/movie_home/home_page_bloc.dart';
import 'package:movieapp/pages/movie_grid/movie_list_bloc.dart';
import 'package:movieapp/pages/movie_grid/movie_list_model.dart';
import 'package:movieapp/pages/movie_home/horizontal_movie_list.dart';
import 'package:movieapp/services/movie_db_api.dart';
import 'package:provider/provider.dart';

class MovieHomePage extends StatelessWidget {
  const MovieHomePage({Key key, this.bloc}) : super(key: key);

  final HomePageBloc bloc;

  static Widget create(BuildContext context) {
    final MovieDbApi movieDpApi =
        Provider.of<MovieDbApi>(context, listen: false);
    return Provider<HomePageBloc>(
      create: (_) => HomePageBloc(movieDpApi: movieDpApi,),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<HomePageBloc>(
          builder: (context, bloc, _) => MovieHomePage(
                bloc: bloc,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc.movieList("/movie/top_rated");
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
