import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db_module2_part1/src/core/util/api_constants.dart';
import 'package:the_movie_db_module2_part1/src/presentation/widget/movie_info_screen/movie_poster.dart';

void main() {
  testWidgets(
    'Verify that the poster image is showed correctly',
    (WidgetTester tester) async {
      const String posterUrl =
          '${ApiConstants.baseUrlForImages}qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg';
      const double posterWidth = 150;
      const double posterHeight = 200;
      await tester.pumpWidget(
        MaterialApp(
          home: MoviePoster(
            posterImageUrl: posterUrl,
            posterImageWidth: posterWidth,
            posterImageHeight: posterHeight,
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    },
  );
}
