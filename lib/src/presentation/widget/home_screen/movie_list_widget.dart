import 'package:flutter/material.dart';
import '../../../domain/repository/i_repository.dart';
import '../custom_text_widget.dart';
import '../../view/app_movie_info_screen.dart';
import 'movie_list_card.dart';
import '../../../data/repository/movie_repository_impl.dart';
import '../../../domain/entity/movie.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({
    super.key,
  });

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  IRepository<List<Movie>> movieRepository = MovieRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movieRepository.getData(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Movie>> data,
      ) {
        if (data.hasError) {
          return CustomText(
            text: '${data.error}',
          );
        } else if (data.hasData) {
          List<Movie> movies = data.data as List<Movie>;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AppMovieInfo(),
                      settings: RouteSettings(
                        arguments: movies[index],
                      ),
                    ),
                  );
                },
                child: MovieListCard(
                  movie: movies[index],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
