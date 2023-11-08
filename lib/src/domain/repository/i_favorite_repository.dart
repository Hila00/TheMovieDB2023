import '../entity/movie.dart';

abstract class IFavoriteRepository {
  void getData();

  void insertFavoriteMovie(Movie movie);

  void removeFavoriteMovie(int id);
}
