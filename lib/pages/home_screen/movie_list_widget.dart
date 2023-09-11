import 'package:flutter/material.dart';
import '/custom_text_widget.dart';
import '/pages/movie_info_screen/app_movie_info.dart';
import '/pages/home_screen/movie_list_card.dart';
import '/repository/movie_repository.dart';
import '/model/movie_data_model.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({
    super.key,
  });

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  MovieRepository movieRepository = MovieRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movieRepository.getData(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<MovieDataModel>> data,
      ) {
        if (data.hasError) {
          return CustomText(
            text: '${data.error}',
          );
        } else if (data.hasData) {
          List<MovieDataModel> movies = data.data as List<MovieDataModel>;
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
