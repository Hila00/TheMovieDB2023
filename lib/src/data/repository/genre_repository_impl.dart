import 'dart:core';

import '../../core/util/constants.dart';
import '../../core/util/data_state.dart';
import '../../domain/entity/genre.dart';
import '../../domain/repository/i_genre_repository.dart';
import '../datasource/local/DAOs/genre_dao.dart';
import '../datasource/remote/i_api_genres_service.dart';
import '../model/genre_model.dart';
import 'database_repository.dart';

class GenreRepositoryImpl implements IGenreRepository<DataState<List<Genre>>> {
  IApiGenreService genresService;
  DatabaseRepository databaseRepository;

  GenreRepositoryImpl({
    required this.genresService,
    required this.databaseRepository,
  });

  @override
  Future<DataState<List<Genre>>> getData() async {
    GenreDao genreDao = await databaseRepository.getGenreDao();
    DataState dataState = await genresService.fetchGenresFromApi();

    if (dataState is DataSuccess) {
      List<GenreModel> genreModel = dataState.data;
      if (genreModel.isNotEmpty) {
        genreModel.map((genre) => genreDao.insertGenre(genre));
        return DataSuccess<List<Genre>>(genreModel);
      }
    }

    return _getDatabaseState();
  }

  Future<DataState<List<Genre>>> _getDatabaseState() async {
    GenreDao genreDao = await databaseRepository.getGenreDao();
    List<Genre> genresFromDB = await genreDao.getAllGenres();
    if (genresFromDB.isNotEmpty) {
      return DataSuccess(
        genresFromDB,
      );
    } else {
      return DataError(
        Exception(AppConstants.databaseError),
      );
    }
  }
}
