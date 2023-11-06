import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:the_movie_db_module2_part1/src/presentation/widget/movie_info_screen/movie_like_button.dart';

void main() {
  testWidgets(
    'Verify like button is working properly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MovieLikeButton(),
        ),
      );

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byKey(const Key('LikeButtonKey')), findsOneWidget);
      await tester.tap(find.byKey(const Key('LikeButtonKey')));
      await tester.pump();
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    },
  );
}
