import 'package:advicer/0_data/datasources/advice_remote_datasource.dart';
import 'package:advicer/0_data/exceptions/exceptions.dart';
import 'package:advicer/1_domain/entities/advice_entity.dart';
import 'package:advicer/1_domain/failures/failures.dart';
import 'package:advicer/1_domain/repositories/advice_repo.dart';
import 'package:dartz/dartz.dart';

class AdviceRepoImpl implements AdviceRepo {
  final AdviceRemoteDatasource adviceRemoteDatasource;
  AdviceRepoImpl({required this.adviceRemoteDatasource});
  @override
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    try {
      final result = await adviceRemoteDatasource.getAdviceFromApi();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure());
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}
