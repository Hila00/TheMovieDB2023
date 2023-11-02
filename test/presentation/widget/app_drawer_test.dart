import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:the_movie_db_module2_part1/src/presentation/widget/app_drawer.dart';

Widget buildWidget() {
  return const MaterialApp(
    home: AppDrawer(),
  );
}

void main() {
  group(
    'AppDrawer functionalities test',
    () {
      testWidgets(
        'Confirm drawer is displayed',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            buildWidget(),
          );

          expect(find.byType(Drawer), findsOneWidget);
          expect(find.byType(DrawerHeader), findsOneWidget);
          expect(find.byType(ListView), findsOneWidget);
          expect(find.byType(Text), findsWidgets);
        },
      );

      testWidgets(
        'Confirm drawer tiles are working',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            buildWidget(),
          );

          expect(find.byType(DrawerListTile), findsWidgets);
        },
      );
    },
  );
}
