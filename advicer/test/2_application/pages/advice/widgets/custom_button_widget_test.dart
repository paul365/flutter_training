import 'package:advicer/2_application/pages/advice/widgets/custom_button.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

abstract class OnCustomButtonTap {
  void call();
}

class MockOnCustomButtonTap extends Mock implements OnCustomButtonTap {}

void main() {
  Widget widgetUnderMethod({Function()? callback}) {
    return MaterialApp(
      home: Scaffold(
        body: CustomButton(
          onTap: callback?.call(),
        ),
      ),
    );
  }

  group('CustomButton', () {
    group('is Button rendered correctly', () {
      testWidgets('and has all parts that he needs', (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderMethod());
        final buttonLabelFinder = find.text('Get Advice');

        expect(buttonLabelFinder, findsOneWidget);
      });
    });

    group('should handle onTap', () {
      testWidgets('when someone has pressed the button', (widgetTester) async {
        final mockOnCustomTap = MockOnCustomButtonTap();
        await widgetTester
            .pumpWidget(widgetUnderMethod(callback: mockOnCustomTap));
        final buttonLabelFinder = find.byType(CustomButton);

        await widgetTester.tap(buttonLabelFinder);

        verify(mockOnCustomTap()).called(1);

        // expect(buttonLabelFinder, findsOneWidget);
      });
    });
  });
}
