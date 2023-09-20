import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db_module2_part1/src/presentation/widget/app_circular_progress_indicator.dart';

void main() {
  Widget buildWidget() {
    return const MaterialApp(
      home: CustomCircularProgressIndicator(),
    );
  }

  testWidgets(
    'Test CircularProgressIndicator is displayed properly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        buildWidget(),
      );

      expect(find.byType(CustomCircularProgressIndicator), findsOneWidget);
    },
  );
}
