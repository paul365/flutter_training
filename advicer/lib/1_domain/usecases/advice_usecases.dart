import 'package:advicer/0_data/repositories/advice_repo_impl.dart';
import 'package:advicer/1_domain/entities/advice_entity.dart';
import 'package:advicer/1_domain/failures/failures.dart';
import 'package:advicer/1_domain/repositories/advice_repo.dart';
import 'package:dartz/dartz.dart';

class AdviceUseCases {
  final AdviceRepo adviceRepo;

  AdviceUseCases({required this.adviceRepo});

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    // await Future.delayed(const Duration(seconds: 3), () {});
    // return right(AdviceEntity(advice: 'This is your advice', id: 1));
    // return left(ServerFailure());
    return adviceRepo.getAdvice();
  }
}
