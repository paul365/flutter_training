import 'package:advicer/2_application/pages/advice/bloc/advicer_bloc.dart';
import 'package:test/scaffolding.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('AdvicerBloc', () {
    group('should emit', () {
      blocTest<AdvicerBloc, AdvicerState>(
        'nothing when no event is added.',
        build: () => AdvicerBloc(),
        expect: () => const <AdvicerState>[],
      );

      blocTest(
        // '[AdvicerStateLoading, AdvicerStateError] when AdvicerRequestedEvent is added',
        '[AdvicerStateLoading, AdvicerStateLoaded] when AdvicerRequestedEvent is added',
        build: () => AdvicerBloc(),
        act: (bloc) => bloc.add(AdviceRequested()),
        wait: const Duration(seconds: 3),
        expect: () => <AdvicerState>[
          AdvicerStateLoading(),
          // AdvicerStateError(message: 'fake advice'),
          AdvicerStateLoaded(advice: 'fake advice'),
        ],
      );
    });
  });
}
