import 'i_bloc.dart';

abstract class IMoviesBloc extends IBloc {
  void fetchPopularMovies();

  void fetchTopRatedMovies();

  void fetchNowPlayingMovies();

  void fetchSavedMoviesFromDb();
}
