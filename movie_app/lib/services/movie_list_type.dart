abstract class MovieListType {
  final String apiName;
  final String title;

  MovieListType(this.apiName, this.title);
}

class TopRated extends MovieListType {
  TopRated(
      {String apiName = "/movie/top_rated", String title = "Top Rated Movies"})
      : super(apiName, title);
}

class NowPlaying extends MovieListType {
  NowPlaying(
      {String apiName = "/movie/now_playing",
        String title = "Movies Now Playing"})
      : super(apiName, title);
}

class Popular extends MovieListType {
  Popular({String apiName = "/movie/popular", String title = "Popular Movies"})
      : super(apiName, title);
}

class Upcoming extends MovieListType {
  Upcoming(
      {String apiName = "/movie/upcoming", String title = "Upcoming Movies"})
      : super(apiName, title);
}
const MOVIE_LIST_TYPES = [TopRated, NowPlaying, Popular, Upcoming];