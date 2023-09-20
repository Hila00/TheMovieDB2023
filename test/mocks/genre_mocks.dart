import 'package:the_movie_db_module2_part1/src/data/model/genre_model.dart';
import 'package:the_movie_db_module2_part1/src/domain/entity/genre.dart';

class GenreMocks {
  static List<Genre> mockedGenreList = [
    mockedGenre,
  ];

  static List<Genre> mockedGenreEmptyList = [];

  static final Genre mockedGenre = Genre(id: 53, name: "Thriller");

  static List<GenreModel> mockedGenreModelList = [
    mockedGenreModel,
  ];

  static List<GenreModel> mockedGenreModelEmptyList = [];

  static final GenreModel mockedGenreModel =
      GenreModel(id: 12, name: "Adventure");
}
