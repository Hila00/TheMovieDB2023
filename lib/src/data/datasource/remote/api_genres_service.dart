import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../../core/util/api_constants.dart';
import '../../../core/util/data_state.dart';
import '../../model/genre_model.dart';
import 'i_api_genres_service.dart';

class ApiGenresService extends IApiGenreService {
  @override
  Future fetchGenresFromApi() async {
    try {
      final Response response = await get(
        Uri.parse(ApiConstants.baseUrlForGenres),
        headers: {
          HttpHeaders.authorizationHeader: ApiConstants.apiBearerToken,
        },
      );
      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> json = jsonDecode(response.body);

        return DataSuccess(
          List<dynamic>.from(json['genres'])
              .map((genre) => GenreModel.fromJson(genre))
              .toList(),
        );
      } else {
        return DataError(
          Exception('${ApiConstants.errorMessage}${response.statusCode}'),
        );
      }
    } catch (e) {
      return DataError(
        Exception(ApiConstants.errorMessage),
      );
    }
  }
}
