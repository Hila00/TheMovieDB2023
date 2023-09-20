import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db_module2_part1/src/core/util/api_constants.dart';
import 'package:the_movie_db_module2_part1/src/presentation/widget/home_screen/movie_card.dart';
import '../../../mocks/movie_mocks.dart';

void main() {
  String mockedMovieUrl = MovieMocks.mockedMovie.posterUrl;
  Widget buildWidget() {
    return MaterialApp(
      home: MovieCard(
        moviePosterUrl: '${ApiConstants.baseUrlForImages}$mockedMovieUrl',
      ),
    );
  }

  group(
    'Movie Poster',
    () {
      testWidgets(
        'Movie title should be displayed',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            buildWidget(),
          );

          expect(find.byType(CachedNetworkImage), findsOneWidget);
        },
      );

      testWidgets(
        'Movie title is not overflowing the screen ',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            buildWidget(),
          );
          final screenWidth =
              MediaQuery.of(tester.element(find.byType(MaterialApp)))
                  .size
                  .width;
          final screenHeight =
              MediaQuery.of(tester.element(find.byType(MaterialApp)))
                  .size
                  .height;
          final cachedNetworkImage = tester
              .widget<CachedNetworkImage>(find.byType(CachedNetworkImage));

          expect(cachedNetworkImage.width! <= screenWidth, true);
          expect(cachedNetworkImage.height! <= screenHeight, true);
        },
      );
    },
  );
}
