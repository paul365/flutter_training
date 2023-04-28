import 'package:advicer/2_application/pages/advice/widgets/advice_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widgetUnderText({required String adviceText}) {
    return MaterialApp(
      home: Scaffold(
        body: AdviceField(advice: adviceText),
      ),
    );
  }

  group(
      'AdviceField',
      () => {
            group('should be displayed correctly', () {
              testWidgets('when a short text is given', (widgetTester) async {
                const text = 'a';
                await widgetTester
                    .pumpWidget(widgetUnderText(adviceText: text));
                await widgetTester.pumpAndSettle();

                final adviceFieldFinder = find.textContaining(text);
                expect(adviceFieldFinder, findsOneWidget);
              });

              testWidgets('when a very long text is given',
                  (widgetTester) async {
                const text =
                    'hello world, this is a very long text that should be displayed correctly';
                await widgetTester
                    .pumpWidget(widgetUnderText(adviceText: text));
                await widgetTester.pumpAndSettle();

                final adviceFieldFinder = find.byType(AdviceField);
                expect(adviceFieldFinder, findsOneWidget);
              });

              testWidgets('when no text is given', (widgetTester) async {
                const text = '';
                await widgetTester
                    .pumpWidget(widgetUnderText(adviceText: text));
                await widgetTester.pumpAndSettle();

                final adviceFieldFinder = find.byType(AdviceField);
                expect(adviceFieldFinder, findsOneWidget);
              });
            })
          });
}
