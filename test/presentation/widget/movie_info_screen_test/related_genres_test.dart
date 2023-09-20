import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db_module2_part1/src/presentation/widget/movie_info_screen/related_genres_title.dart';

void main() {
  testWidgets(
    'The widget should show its default text',
    (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RelatedGenresTitle(),
        ),
      );

      expect(find.textContaining('Related genres'), findsOneWidget);
    },
  );
}
