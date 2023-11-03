import '../../data/datasource/local/movie_database.dart';
import '../../data/datasource/remote/api_genres_service.dart';
import '../../data/datasource/remote/api_movie_service.dart';
import '../../data/repository/genre_repository_impl.dart';
import '../../data/repository/movie_repository_impl.dart';
import '../../domain/usecase/implementation/genres_use_case.dart';
import '../../domain/usecase/implementation/movies_use_case.dart';
import '../../presentation/bloc/genres_bloc.dart';
import '../../presentation/bloc/movies_bloc.dart';
import '../../presentation/bloc/trailers_screen_bloc.dart';
import 'api_constants.dart';
import 'constants.dart';

class BlocSingletonDependencies {
  late AppDatabase database;
  late MoviesBloc moviesBloc;
  late MoviesUseCase moviesUseCase;
  late GenresBloc genresBloc;
  late TrailersBloc trailersBloc;

  Future<void> initialize() async {
    database = await $FloorAppDatabase
        .databaseBuilder(AppConstants.databaseAccessString)
        .build();
    moviesUseCase = MoviesUseCase(
      movieRepository: MovieRepositoryImpl(
        movieService: ApiMovieService(),
        database: database,
      ),
      categoryEndPoint: ApiConstants.upComingMoviesEndPoint,
    );

    moviesBloc = MoviesBloc(
      moviesUseCase: moviesUseCase,
    );
    genresBloc = GenresBloc(
      genresUseCase: GenresUseCase(
        genreRepository: GenreRepositoryImpl(
          genresService: ApiGenresService(),
          database: database,
        ),
      ),
    );

    trailersBloc = TrailersBloc(
      useCase: moviesUseCase,
    );
  }
}
