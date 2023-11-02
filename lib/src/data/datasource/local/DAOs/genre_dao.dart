import 'package:floor/floor.dart';

import '../../../../domain/entity/genre.dart';

@dao
abstract class GenreDao {
  @Query('SELECT * FROM Genre')
  Future<List<Genre>> getAllGenres();

  @Query('SELECT * FROM Genre WHERE id = :id')
  Future<Genre?> getGenreById(int id);

  @Query('SELECT * FROM Genre LIMIT 1')
  Future<List<Genre>> getFirstGenre();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertGenre(Genre genre);

  @Query('DELETE FROM Genre WHERE id = :id')
  Future<void> deleteGenreById(int id);
}
