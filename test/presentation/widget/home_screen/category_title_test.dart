import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:the_movie_db_module2_part1/src/presentation/widget/home_screen/category_title.dart';

void main() {
  const String categoryTitle = 'Now Playing';
  const double categoryTitleFontSize = 30;
  const double arrowIconSize = 40;
  Widget buildWidget() {
    return const MaterialApp(
      home: CategoryTitle(
        title: categoryTitle,
        titleFontSize: categoryTitleFontSize,
        arrowIconSize: arrowIconSize,
      ),
    );
  }

  group(
    'Category title',
    () {
      testWidgets(
        'Category title should be displayed',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            buildWidget(),
          );

          expect(find.textContaining(categoryTitle), findsOneWidget);
          expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
        },
      );
    },
  );
}
