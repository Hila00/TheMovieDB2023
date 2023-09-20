import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db_module2_part1/src/core/util/constants.dart';
import 'package:the_movie_db_module2_part1/src/core/util/error_message_widget.dart';

void main() {
  Widget buildWidget() {
    return const MaterialApp(
      home: ErrorMessage(),
    );
  }

  testWidgets(
    'Error widget is being correctly displayed',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        buildWidget(),
      );

      expect(find.textContaining(AppConstants.errorMessage), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    },
  );
}
