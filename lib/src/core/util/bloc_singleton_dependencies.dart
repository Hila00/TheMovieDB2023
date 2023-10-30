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

class BlocSingletonDependencies {
  static MoviesBloc moviesBloc = MoviesBloc(
    popularMoviesUseCase: MoviesUseCase(
      movieRepository: MovieRepositoryImpl(
        movieService: ApiMovieService(
          endPoint: ApiConstants.popularMoviesEndPoint,
        ),
      ),
    ),
    topRatedMoviesUseCase: MoviesUseCase(
      movieRepository: MovieRepositoryImpl(
        movieService: ApiMovieService(
          endPoint: ApiConstants.topRatedMoviesEndPoint,
        ),
      ),
    ),
    nowPlayingMoviesUseCase: MoviesUseCase(
      movieRepository: MovieRepositoryImpl(
        movieService: ApiMovieService(
          endPoint: ApiConstants.nowPlayingMoviesEndPoint,
        ),
      ),
    ),
  );

  static TrailersBloc trailersBloc = TrailersBloc(
    useCase: MoviesUseCase(
      movieRepository: MovieRepositoryImpl(
        movieService: ApiMovieService(
          endPoint: ApiConstants.upComingMoviesEndPoint,
        ),
      ),
    ),
  );

  static GenresBloc genresBloc = GenresBloc(
    genresUseCase: GenresUseCase(
      genreRepository: GenreRepositoryImpl(
        genresService: ApiGenresService(),
      ),
    ),
  );
}