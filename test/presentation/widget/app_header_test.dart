import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:the_movie_db_module2_part1/src/core/util/constants.dart';
import 'package:the_movie_db_module2_part1/src/presentation/widget/app_header.dart';

Widget buildWidget() {
  return const MaterialApp(
    home: AppHeader(),
  );
}

void main() {
  group(
    'AppHeader functionalities test',
    () {
      testWidgets(
        'App title and menu icon are displayed successfully',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            buildWidget(),
          );

          expect(find.textContaining(AppConstants.appTitle), findsOneWidget);
          expect(find.byIcon(Icons.menu), findsOneWidget);
        },
      );
    },
  );
}
