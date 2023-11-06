import 'i_bloc.dart';

abstract class IMoviesBloc extends IBloc {
  void fetchMovies(String endPoint);
}
