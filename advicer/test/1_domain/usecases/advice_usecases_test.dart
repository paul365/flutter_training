import 'package:advicer/0_data/exceptions/exceptions.dart';
import 'package:advicer/0_data/repositories/advice_repo_impl.dart';
import 'package:advicer/1_domain/entities/advice_entity.dart';
import 'package:advicer/1_domain/failures/failures.dart';
import 'package:advicer/1_domain/usecases/advice_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRepoImpl>()])
void main() {
  group('AdviceUsecases', () {
    group('getAdvice', () {
      test('should return AdviceModel', () async {
        final mockAdviceRepo = MockAdviceRepoImpl();
        final adviceUsecasesUnderTest =
            AdviceUseCases(adviceRepo: mockAdviceRepo);

        when(mockAdviceRepo.getAdvice()).thenAnswer((realInvocation) =>
            Future.value(const Right(AdviceEntity(advice: 'test', id: 1))));

        final result = await adviceUsecasesUnderTest.getAdvice();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(
            result,
            const Right<Failure, AdviceEntity>(
                AdviceEntity(advice: 'test', id: 1)));
        verify(mockAdviceRepo.getAdvice()).called(1);
        verifyNoMoreInteractions(mockAdviceRepo);
      });
    });

    group('should return left with', () {
      test('a ServerFailure', () async {
        final mockAdviceRepo = MockAdviceRepoImpl();
        final adviceUsecasesUnderTest =
            AdviceUseCases(adviceRepo: mockAdviceRepo);

        when(mockAdviceRepo.getAdvice()).thenAnswer(
            (realInvocation) => Future.value(Left(ServerFailure())));

        final result = await adviceUsecasesUnderTest.getAdvice();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(ServerFailure()));
        verify(mockAdviceRepo.getAdvice()).called(1);
        verifyNoMoreInteractions(mockAdviceRepo);
      });

      test('a GeneralFailure on all other Exceptions', () async {
        final mockAdviceRepo = MockAdviceRepoImpl();
        final adviceUsecasesUnderTest =
            AdviceUseCases(adviceRepo: mockAdviceRepo);

        when(mockAdviceRepo.getAdvice())
            .thenAnswer((_) => Future.value(Left(GeneralFailure())));

        final result = await adviceUsecasesUnderTest.getAdvice();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(GeneralFailure()));
        verify(mockAdviceRepo.getAdvice()).called(1);
        verifyNoMoreInteractions(mockAdviceRepo);
      });
    });
  });
}
