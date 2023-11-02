import '../../data/datasource/remote/api_genres_service.dart';
import '../../data/datasource/remote/api_movie_service.dart';
import '../../data/repository/database_repository.dart';
import '../../data/repository/genre_repository_impl.dart';
import '../../data/repository/movie_repository_impl.dart';
import '../../domain/usecase/implementation/genres_use_case.dart';
import '../../domain/usecase/implementation/movies_use_case.dart';
import '../../presentation/bloc/genres_bloc.dart';
import '../../presentation/bloc/movies_bloc.dart';
import '../../presentation/bloc/trailers_screen_bloc.dart';

class BlocSingletonDependencies {
  static DatabaseRepository dbRepo = DatabaseRepository();

  static MoviesUseCase moviesUseCase = MoviesUseCase(
    movieRepository: MovieRepositoryImpl(
      movieService: ApiMovieService(),
      databaseInstance: dbRepo,
    ),
  );

  static GenresUseCase genresUseCase = GenresUseCase(
    genreRepository: GenreRepositoryImpl(
      genresService: ApiGenresService(),
      databaseRepository: dbRepo,
    ),
  );

  static MoviesBloc moviesBloc = MoviesBloc(
    moviesUseCase: moviesUseCase,
  );

  static TrailersBloc trailersBloc = TrailersBloc(
    useCase: moviesUseCase,
  );

  static GenresBloc genresBloc = GenresBloc(
    genresUseCase: genresUseCase,
  );
}
