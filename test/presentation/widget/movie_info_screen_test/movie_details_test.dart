import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:the_movie_db_module2_part1/src/presentation/widget/movie_info_screen/movie_details.dart';

void main() {
  const String movieTitle = 'The super mario bros';
  const String movieReleaseDate = '03-09-2008';
  const double movieVoteAverage = 8.9;
  Widget buildWidget() {
    return const MaterialApp(
      home: MovieDetails(
        movieTitle: movieTitle,
        movieReleaseDate: movieReleaseDate,
        movieVoteAverage: movieVoteAverage,
      ),
    );
  }

  group(
    'Movie Title',
    () {
      testWidgets(
        'Movie title should be displayed',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            buildWidget(),
          );

          expect(find.textContaining(movieTitle), findsOneWidget);
          expect(find.byKey(const Key('MovieTitleKey')), findsOneWidget);
        },
      );
    },
  );

  testWidgets(
    'Movie release date should be displayed',
    (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildWidget(),
      );

      expect(find.textContaining(movieReleaseDate), findsOneWidget);
    },
  );

  testWidgets(
    'Movie vote average displayed',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        buildWidget(),
      );

      expect(find.textContaining(movieVoteAverage.toString()), findsOneWidget);
    },
  );
}
