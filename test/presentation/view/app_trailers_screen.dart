import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db_module2_part1/src/presentation/widget/trailers_screen/trailer_card.dart';
import '../../mocks/movie_mocks.dart';

void main() {
  Widget buildWidget() {
    return MaterialApp(
      home: TrailerCard(
        movie: MovieMocks.mockedMovie,
      ),
    );
  }

  testWidgets(
    'Movie trailer is being showed properly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        buildWidget(),
      );

      expect(find.byType(CachedNetworkImage), findsOneWidget);
      expect(find.textContaining(MovieMocks.mockedMovie.title), findsOneWidget);
    },
  );
}
