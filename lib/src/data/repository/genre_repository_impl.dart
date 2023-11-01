import 'dart:core';
import '../../core/util/constants.dart';
import '../../domain/entity/genre.dart';
import '../../domain/repository/i_repository.dart';
import '../datasource/local/DAOs/genre_dao.dart';
import '../datasource/local/movie_database.dart';
import '../datasource/remote/i_api_service.dart';
import '../../core/util/data_state.dart';
import '../model/genre_model.dart';

class GenreRepositoryImpl implements IRepository<DataState<List<Genre>>> {
  IApiService genresService;
  Future<AppDatabase> databaseInstance;

  GenreRepositoryImpl({
    required this.genresService,
    required this.databaseInstance,
  });

  @override
  Future<DataState<List<Genre>>> getData() async {
    AppDatabase database = await databaseInstance;
    DataState dataState = await genresService.fetchDataFromApi();

    if (dataState is DataSuccess) {
      List<GenreModel> genreModel = dataState.data;

      if (genreModel.isNotEmpty) {
        GenreDao genreDao = database.genreDao;
        genreModel.map((genre) => genreDao.insertGenre(genre));
        return DataSuccess<List<Genre>>(genreModel);
      } else {
        return getDatabaseState();
      }
    } else {
      return getDatabaseState();
    }
  }

  Future<DataState<List<Genre>>> getDatabaseState() async {
    AppDatabase database = await databaseInstance;
    GenreDao genreDao = database.genreDao;
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
