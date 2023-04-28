import 'package:advicer/1_domain/entities/advice_entity.dart';
import 'package:advicer/1_domain/failures/failures.dart';
import 'package:advicer/1_domain/usecases/advice_usecases.dart';
import 'package:advicer/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAdviceUseCases extends Mock implements AdviceUseCases {}

void main() {
  group('AdvicerCubit', () {
    MockAdviceUseCases mac = MockAdviceUseCases();
    group('should emit', () {
      blocTest(
        'nothing when no method is called',
        build: () => AdvicerCubit(adviceUseCases: mac),
        expect: () => const <AdvicerCubitState>[],
      );

      blocTest(
          '[AdvicerStateLoading, AdvicerStateLoaded] when adviceRequested() is called',
          setUp: () {
            when(() => mac.getAdvice()).thenAnswer(
              (_) => Future.value(
                const Right(
                  AdviceEntity(
                    advice: 'fake advice',
                    id: 1,
                  ),
                ),
              ),
            );
          },
          build: () => AdvicerCubit(adviceUseCases: mac),
          act: (cubit) => cubit.adviceRequested(),
          expect: () => <AdvicerCubitState>[
                AdvicerStateLoading(),
                AdvicerStateLoaded(advice: 'fake advice')
              ]);
    });

    group(
      '[AdvicerStateLoading, AdvicerStateError] when adviceRequested is called',
      () => {
        blocTest('and a ServerFailure occurs',
            setUp: () {
              when(() => mac.getAdvice()).thenAnswer(
                (_) => Future.value(
                  Left(ServerFailure()),
                ),
              );
            },
            build: () => AdvicerCubit(adviceUseCases: mac),
            act: (cubit) => cubit.adviceRequested(),
            expect: () => <AdvicerCubitState>[
                  AdvicerStateLoading(),
                  AdvicerStateError(message: 'Server Failed')
                ]),
        blocTest('and a CacheFailure occurs',
            setUp: () {
              when(() => mac.getAdvice()).thenAnswer(
                (_) => Future.value(
                  Left(CacheFailure()),
                ),
              );
            },
            build: () => AdvicerCubit(adviceUseCases: mac),
            act: (cubit) => cubit.adviceRequested(),
            expect: () => <AdvicerCubitState>[
                  AdvicerStateLoading(),
                  AdvicerStateError(message: 'Cache Failed')
                ]),
        blocTest('and a GeneralFailure occurs',
            setUp: () {
              when(() => mac.getAdvice()).thenAnswer(
                (_) => Future.value(
                  Left(GeneralFailure()),
                ),
              );
            },
            build: () => AdvicerCubit(adviceUseCases: mac),
            act: (cubit) => cubit.adviceRequested(),
            expect: () => <AdvicerCubitState>[
                  AdvicerStateLoading(),
                  AdvicerStateError(
                      message: 'Something went wrong. Please try again.')
                ])
      },
    );
  });
}
