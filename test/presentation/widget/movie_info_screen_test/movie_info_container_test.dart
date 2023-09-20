import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db_module2_part1/src/core/util/api_constants.dart';
import 'package:the_movie_db_module2_part1/src/presentation/widget/movie_info_screen/movie_details.dart';
import 'package:the_movie_db_module2_part1/src/presentation/widget/movie_info_screen/movie_info_container.dart';
import 'package:the_movie_db_module2_part1/src/presentation/widget/movie_info_screen/movie_like_button.dart';
import 'package:the_movie_db_module2_part1/src/presentation/widget/movie_info_screen/movie_poster.dart';

void main() {
  const String mockedPosterUrl =
      '${ApiConstants.baseUrlForImages}qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg';
  const String mockedReleaseDate = '08-03-2022';
  const String mockedTitle = 'Movie title mock';
  const double mockedVoteAverage = 9.7;

  Widget buildWidget() {
    return const MaterialApp(
      home: MovieInfoContainer(
        posterUrl: mockedPosterUrl,
        title: mockedTitle,
        releaseDate: mockedReleaseDate,
        voteAverage: mockedVoteAverage,
      ),
    );
  }

  group(
    'MoviePoster',
    () {
      testWidgets(
        'MoviePoster widget is displayed correctly',
        (
          WidgetTester tester,
        ) async {
          await tester.pumpWidget(
            buildWidget(),
          );

          expect(find.byType(MoviePoster), findsOneWidget);
        },
      );
    },
  );

  group(
    'MovieDetails',
    () {
      testWidgets(
        'MovieDetails widget is displayed correctly',
        (
          WidgetTester tester,
        ) async {
          await tester.pumpWidget(
            buildWidget(),
          );

          expect(find.byType(MovieDetails), findsOneWidget);
        },
      );
    },
  );

  group(
    'MovieLikeButton',
    () {
      testWidgets(
        'MovieLikeButton is displayed correctly',
        (
          WidgetTester tester,
        ) async {
          await tester.pumpWidget(
            buildWidget(),
          );

          expect(find.byType(MovieLikeButton), findsOneWidget);
        },
      );
    },
  );
}
