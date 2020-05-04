import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common_widgets/grid_list.dart';
import 'package:movieapp/event/grid_event.dart';
import 'package:movieapp/pages/movie_grid/states_bloc/movie_grid_bloc_states.dart';
import 'package:movieapp/services/constants.dart' as Constants;
import 'package:movieapp/services/movie_db_api.dart';
import 'package:provider/provider.dart';

import 'movie_grid_state.dart';

class MovieGridPageStates extends StatefulWidget {
  const MovieGridPageStates({Key key}) : super(key: key);

  static Widget create(
      BuildContext context, Constants.MovieListType movieListType) {
    final MovieDbApi movieDpApi =
        Provider.of<MovieDbApi>(context, listen: false);
//    BlocSupervisor.delegate = SimpleBlocDelegate();
    return BlocProvider(
      create: (context) => MovieGridBlocStates(
          movieDpApi: movieDpApi, movieListType: movieListType)
        ..add(FetchGridEvent()),
      child: MovieGridPageStates(),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return MovieGridPageStatesState();
  }
}

//unused at the moment but can be good for analytics
class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }
}

class MovieGridPageStatesState extends State<MovieGridPageStates> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  MovieGridBlocStates _bloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _bloc = BlocProvider.of<MovieGridBlocStates>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(_bloc.movieListType.title),
      ),
      body: BlocBuilder<MovieGridBlocStates, MovieGridState>(
        builder: (context, state) {
          if (state is MovieGridUninitialized) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MovieGridError) {
            return Center(
              child: Text('failed to fetch posts'),
            );
          }
          if (state is MovieGridLoaded) {
            if (state.movies.isEmpty) {
              return Center(
                child: Text('no posts'),
              );
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              controller: _scrollController,
              itemCount: state.hasReachedMax
                  ? state.movies.length
                  : state.movies.length + 1,
              padding: const EdgeInsets.all(8),
              itemBuilder: (_, index) {
                return index >= state.movies.length
                    ? BottomLoader()
                    : GestureDetector(
                        onTap: () => _bloc.add(ClickMovieGridEvent(context: context, movie: state.movies[index])),
                        //()=>_navigateToDetailedPage(context,movie),
                        child: GridMovieItem(
                          movie: state.movies[index],
                        ),
                      );
              },
            );
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _bloc.add(FetchGridEvent());
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
