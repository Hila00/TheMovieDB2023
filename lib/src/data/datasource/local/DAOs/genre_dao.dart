import 'package:floor/floor.dart';
import '../../../../domain/entity/genre.dart';

@dao
abstract class GenreDao {
  @Query('SELECT * FROM genre')
  Future<List<Genre>> getAllGenres();

  @Query('SELECT * FROM genre WHERE id = :id')
  Future<Genre?> getGenreById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertGenre(Genre genre);
}
