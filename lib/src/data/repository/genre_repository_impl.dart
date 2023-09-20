import 'dart:core';
import '../../core/util/api_constants.dart';
import '../../domain/entity/genre.dart';
import '../../domain/repository/i_repository.dart';
import '../datasource/remote/i_api_service.dart';
import '../../core/util/data_state.dart';
import '../model/genre_model.dart';

class GenreRepositoryImpl implements IRepository<DataState<List<Genre>>> {
  IApiService genresService;

  GenreRepositoryImpl({
    required this.genresService,
  });

  @override
  Future<DataState<List<Genre>>> getData() async {
    DataState dataState = await genresService.fetchDataFromApi();
    if (dataState is DataSuccess) {
      List<GenreModel> genreModel = dataState.data;

      if (genreModel.isNotEmpty) {
        return DataSuccess<List<Genre>>(genreModel);
      } else {
        return DataError(
          Exception(ApiConstants.errorMessage),
        );
      }
    } else {
      return DataError(
        Exception(dataState.error),
      );
    }
  }
}
