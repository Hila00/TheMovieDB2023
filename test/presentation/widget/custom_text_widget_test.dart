import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:the_movie_db_module2_part1/src/core/util/constants.dart';
import 'package:the_movie_db_module2_part1/src/presentation/widget/custom_text_widget.dart';

void main() {
  const String testString = 'Testing text';

  group(
    "Testing widget's behaviour",
    () {
      testWidgets(
        'Widget is displayed properly',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              home: CustomText(
                text: testString,
              ),
            ),
          );

          expect(find.textContaining(testString), findsOneWidget);
        },
      );

      testWidgets(
        'Test if the text attributes are displayed properly',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              home: CustomText(
                text: testString,
                fontSize: 30,
                color: AppConstants.appFontColor,
              ),
            ),
          );

          final textWidget = tester.widget<CustomText>(find.byType(CustomText));

          expect(find.textContaining(testString), findsOneWidget);
          expect(textWidget.color, AppConstants.appFontColor);
          expect(textWidget.fontSize, 30);
        },
      );
    },
  );
}
