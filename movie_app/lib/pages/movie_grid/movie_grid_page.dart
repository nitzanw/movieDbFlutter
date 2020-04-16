import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/common_widgets/grid_list.dart';
import 'package:movieapp/pages/movie_grid/movie_list_bloc.dart';
import 'package:movieapp/pages/movie_grid/movie_list_model.dart';
import 'package:movieapp/services/movie_db_api.dart';
import 'package:provider/provider.dart';

class MovieGridPage extends StatelessWidget {
  const MovieGridPage({Key key, @required this.bloc}) : super(key: key);
  final MovieListBloc bloc;

  static Widget create(BuildContext context) {
    final MovieDbApi movieDpApi =
        Provider.of<MovieDbApi>(context, listen: false);
    return Provider<MovieListBloc>(
      create: (_) => MovieListBloc(movieDpApi: movieDpApi),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<MovieListBloc>(
          builder: (context, bloc, _) => MovieGridPage(
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
          return GridList(
            eventDispatcher: bloc.eventDispatcher,
            movieListModel: snapshot.data,
          );
        });
  }
}
