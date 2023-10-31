import 'package:floor/floor.dart';

import '../../../../domain/entity/movie.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM Movie')
  Future<List<Movie>> getAllMovies();

  @Query('SELECT name FROM Movie')
  Future<List<String>> getAllMovieTitles();

  @Query('SELECT * FROM Movie WHERE id = :id')
  Future<Movie?> getMovieById(int id);

  @Query('SELECT * FROM Movie LIMIT 1')
  Future<List<Movie>> getFirstMovie();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovie(Movie movie);
}
