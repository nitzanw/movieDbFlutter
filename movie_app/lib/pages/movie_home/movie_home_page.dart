import 'package:flutter/material.dart';
import 'package:movieapp/pages/movie_home/multiple_movie_list_model.dart';
import 'package:movieapp/pages/movie_home/home_page_bloc.dart';
import 'package:movieapp/pages/movie_home/horizontal_movie_list.dart';
import 'package:movieapp/services/constants.dart' as Constants;
import 'package:movieapp/services/movie_db_api.dart';
import 'package:provider/provider.dart';

class MovieHomePage extends StatelessWidget {
  const MovieHomePage({Key key, this.bloc}) : super(key: key);

  final HomePageBloc bloc;

  static Widget create(BuildContext context) {
    final MovieDbApi movieDpApi =
        Provider.of<MovieDbApi>(context, listen: false);
    return Provider<HomePageBloc>(
      create: (_) => HomePageBloc(
        movieDpApi: movieDpApi,
      ),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<HomePageBloc>(
          builder: (context, bloc, _) => MovieHomePage(
                bloc: bloc,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc.movieList(Constants.NowPlaying());
    bloc.movieList(Constants.Popular());
    bloc.movieList(Constants.Upcoming());
    bloc.movieList(Constants.TopRated());
    return StreamBuilder<MultipleMovieListModel>(
      stream: bloc.modelStream,
      initialData: MultipleMovieListModel(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Constants.APP_NAME),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  HorizontalMovieList(
                    movieList: snapshot.data.nowPlayingMovieList,
                    eventDispatcher: bloc.eventDispatcher,
                    movieListType: Constants.NowPlaying(),
                    isLoading: snapshot.data.isLoading,
                  ),
                  HorizontalMovieList(
                    movieList: snapshot.data.popularMovieList,
                    eventDispatcher: bloc.eventDispatcher,
                    movieListType: Constants.Popular(),
                    isLoading: snapshot.data.isLoading,
                  ),
                  HorizontalMovieList(
                    movieList: snapshot.data.upcomingMovieList,
                    eventDispatcher: bloc.eventDispatcher,
                    movieListType: Constants.Upcoming(),
                    isLoading: snapshot.data.isLoading,
                  ),
                  HorizontalMovieList(
                    movieList: snapshot.data.topRatedMovieList,
                    eventDispatcher: bloc.eventDispatcher,
                    movieListType: Constants.TopRated(),
                    isLoading: snapshot.data.isLoading,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
