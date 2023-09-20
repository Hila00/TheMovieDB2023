import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db_module2_part1/src/presentation/view/app_movie_info_screen.dart';
import 'package:the_movie_db_module2_part1/src/presentation/widget/movie_info_screen/movie_info_container.dart';
import 'package:the_movie_db_module2_part1/src/presentation/widget/movie_info_screen/movie_overview.dart';
import 'package:the_movie_db_module2_part1/src/presentation/widget/movie_info_screen/related_genres_title.dart';

import '../../mocks/movie_mocks.dart';

void main() {
  Widget buildWidget() {
    return MaterialApp(
      home: AppMovieInfo(
        movie: MovieMocks.mockedMovie,
      ),
    );
  }

  group(
    'Widgets inside AppMovieInfo screen should be displayed properly',
    () {
      testWidgets(
        'Widgets are displayed',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            buildWidget(),
          );

          expect(find.byType(RelatedGenresTitle), findsOneWidget);
          expect(find.byType(ListView), findsOneWidget);
          expect(find.byType(CachedNetworkImage), findsWidgets);
          expect(find.byType(MovieInfoContainer), findsOneWidget);
          expect(find.byType(MovieOverview), findsOneWidget);
        },
      );

      testWidgets(
        'Movie info should be showed properly',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            buildWidget(),
          );

          expect(
            find.textContaining(MovieMocks.mockedMovie.title),
            findsOneWidget,
          );
          expect(
            find.textContaining(MovieMocks.mockedMovie.overview),
            findsOneWidget,
          );
          expect(
            find.textContaining(MovieMocks.mockedMovie.releaseDate),
            findsOneWidget,
          );
        },
      );
    },
  );
}
