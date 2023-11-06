import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:the_movie_db_module2_part1/src/presentation/widget/home_screen/home_search_bar.dart';

void main() {
  Widget buildWidget() {
    return const MaterialApp(
      home: HomeScreenSearchBar(),
    );
  }

  group(
    'Search bar',
    () {
      testWidgets(
        'Search bar should be displayed',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            buildWidget(),
          );

          expect(find.byType(SearchBar), findsOneWidget);
          expect(find.byIcon(Icons.search), findsOneWidget);
        },
      );
    },
  );
}
