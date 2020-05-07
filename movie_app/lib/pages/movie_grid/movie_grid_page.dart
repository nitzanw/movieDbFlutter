import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/common_widgets/grid_list.dart';
import 'package:movieapp/pages/movie_grid/movie_grid_bloc.dart';
import 'package:movieapp/pages/movie_grid/movie_grid_model.dart';
import 'package:movieapp/services/movie_db_api.dart';
import 'package:movieapp/services/movie_list_type.dart';
import 'package:provider/provider.dart';


class MovieGridPage extends StatelessWidget {
  const MovieGridPage({Key key, @required this.bloc}) : super(key: key);
  final MovieGridBloc bloc;

  static Widget create(BuildContext context, MovieListType movieListType) {
    final MovieDbApi movieDpApi =
        Provider.of<MovieDbApi>(context, listen: false);
    return Provider<MovieGridBloc>(
      create: (_) => MovieGridBloc(movieDpApi: movieDpApi, movieListType: movieListType),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<MovieGridBloc>(
          builder: (context, bloc, _) => MovieGridPage(
                bloc: bloc,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
   bloc.movieList();
    return StreamBuilder<MovieGridModel>(
        stream: bloc.modelStream,
        initialData: MovieGridModel(),
        builder: (context, snapshot) {
          return GridList(
            eventDispatcher: bloc.eventDispatcher,
            movieListModel: snapshot.data,
            title: bloc.movieListType.title,
          );
        });
  }
}


