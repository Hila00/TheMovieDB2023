import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:the_movie_db_module2_part1/src/presentation/widget/movie_info_screen/movie_overview.dart';

void main() {
  testWidgets(
    'Verify movie overview is properly displayed',
    (WidgetTester tester) async {
      const String movieOverview = 'Overview';
      await tester.pumpWidget(
        MaterialApp(
          home: MovieOverview(overview: movieOverview),
        ),
      );

      expect(find.textContaining(movieOverview), findsOneWidget);
    },
  );
}
