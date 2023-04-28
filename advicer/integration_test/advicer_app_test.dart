import 'dart:math';

import 'package:advicer/2_application/pages/advice/widgets/advice_field.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:advicer/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end tst', () {
    testWidgets(
      'tap on custom button, verify advice will be loaded',
      (widgetTester) async {
        app.main();
        await widgetTester.pumpAndSettle();

        expect(find.text('Advice is waiting for you'), findsOneWidget);

        final customButtonFinder = find.text('Get Advice');
        await widgetTester.tap(customButtonFinder);

        await widgetTester.pumpAndSettle();

        expect(find.byType(AdviceField), findsOneWidget);
      },
    );
  });
}
