import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/common_widgets/grid_list.dart';
import 'package:movieapp/pages/movie_list_bloc.dart';
import 'package:movieapp/pages/movie_list_model.dart';
import 'package:movieapp/services/movie_db_api.dart';
import 'package:provider/provider.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key key, @required this.bloc}) : super(key: key);
  final MovieListBloc bloc;

  static Widget create(BuildContext context) {
    final MovieDbApi movieDpApi =
        Provider.of<MovieDbApi>(context, listen: false);
    return Provider<MovieListBloc>(
      create: (_) => MovieListBloc(movieDpApi: movieDpApi),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<MovieListBloc>(
          builder: (context, bloc, _) => MovieListPage(
                bloc: bloc,
              )),
    );
  }

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  @override
  Widget build(BuildContext context) {
    widget.bloc.movieList();
    return StreamBuilder<MovieListModel>(
        stream: widget.bloc.modelStream,
        initialData: MovieListModel(),
        builder: (context, snapshot) {
          return GridList(
//            movieList: bloc.movieList(),
            movieListModel: snapshot.data,
          );
        });
  }
}
