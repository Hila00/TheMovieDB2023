import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../../../domain/entity/genre.dart';
import '../../../domain/entity/movie.dart';
import 'DAOs/genre_dao.dart';
import 'DAOs/movie_dao.dart';
import 'converters/genres_converter.dart';

part 'movie_database.g.dart';

@TypeConverters(
  <Type>[
    GenresConverter,
  ],
)
@Database(
  version: 1,
  entities: [
    Movie,
    Genre,
  ],
)
abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDao;

  GenreDao get genreDao;
}
