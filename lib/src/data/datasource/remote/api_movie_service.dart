import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import '../../../core/util/api_constants.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/data_state.dart';
import '../../model/movie_model.dart';
import 'i_api_service.dart';

class ApiMovieService extends IApiService {
  String endPoint;

  ApiMovieService({
    required this.endPoint,
  });

  @override
  Future<DataState<List<MovieModel>>> fetchDataFromApi() async {
    try {
      final Response response = await get(
        Uri.parse('${ApiConstants.baseUrlForMovies}$endPoint'),
        headers: {
          HttpHeaders.authorizationHeader: ApiConstants.apiBearerToken,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> json = jsonDecode(response.body);
        return DataSuccess(
          List<dynamic>.from(json['results'])
              .map((movie) => MovieModel.fromJson(movie))
              .toList(),
        );
      } else {
        return DataError(
          Exception('${AppConstants.errorMessage}: ${response.statusCode}'),
        );
      }
    } catch (e) {
      return DataError(
        Exception(ApiConstants.errorMessage),
      );
    }
  }
}
