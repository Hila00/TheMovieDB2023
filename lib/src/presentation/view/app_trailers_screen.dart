import 'package:flutter/material.dart';
import '../../core/util/api_constants.dart';
import '../../core/util/error_message_widget.dart';
import '../../data/datasource/remote/api_movie_service.dart';
import '../../data/repository/movie_repository_impl.dart';
import '../../domain/entity/app_event.dart';
import '../../domain/entity/movie.dart';
import '../../domain/usecase/implementation/movies_use_case.dart';
import '../bloc/trailers_screen_bloc.dart';
import '../widget/app_circular_progress_indicator.dart';
import '../widget/custom_text_widget.dart';
import '../widget/trailers_screen/trailer_card.dart';

class AppTrailersScreen extends StatefulWidget {
  static const double backIconMarginLeft = 15;
  static const double backIconMarginTop = 10;
  static const double backIconSize = 37;
  static const String trailersTitle = 'Trailers';
  static const double trailersTitleSize = 40;
  static const subtitle = 'Scroll down to see others!';
  static const double subtitleSize = 25;
  static const double arrowDownSize = 40;
  final TrailersBloc bloc = TrailersBloc(
    useCase: MoviesUseCase(
      movieRepository: MovieRepositoryImpl(
        movieService: ApiMovieService(
          endPoint: ApiConstants.nowPlayingMoviesEndPoint,
        ),
      ),
    ),
  );

  AppTrailersScreen({
    super.key,
  });

  @override
  State<AppTrailersScreen> createState() => _AppTrailersScreenState();
}

class _AppTrailersScreenState extends State<AppTrailersScreen> {
  @override
  void initState() {
    super.initState();
    widget.bloc.fetchAllTrailers();
  }

  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: AppTrailersScreen.backIconMarginLeft,
                      top: AppTrailersScreen.backIconMarginTop,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: AppTrailersScreen.backIconSize,
                    ),
                  ),
                ),
              ],
            ),
            const Center(
              child: CustomText(
                text: AppTrailersScreen.trailersTitle,
                fontSize: AppTrailersScreen.trailersTitleSize,
              ),
            ),
            const CustomText(
              text: AppTrailersScreen.subtitle,
              fontSize: AppTrailersScreen.subtitleSize,
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: AppTrailersScreen.arrowDownSize,
            ),
            Flexible(
              child: StreamBuilder(
                stream: widget.bloc.allTrailers,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<AppEvent> snapshot,
                ) {
                  if (snapshot.data?.status == Status.success) {
                    List<Movie> movies = snapshot.data?.data as List<Movie>;
                    return PageView.builder(
                      itemCount: movies.length,
                      controller: PageController(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (
                        BuildContext context,
                        int index,
                      ) {
                        return TrailerCard(
                          movie: movies[index],
                        );
                      },
                    );
                  } else if (snapshot.data?.status == Status.error ||
                      snapshot.data?.status == Status.empty) {
                    return const ErrorMessage();
                  } else {
                    return const CustomCircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
