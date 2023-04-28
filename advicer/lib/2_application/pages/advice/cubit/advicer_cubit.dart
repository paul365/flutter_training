import 'package:advicer/1_domain/failures/failures.dart';
import 'package:advicer/1_domain/usecases/advice_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'advicer_state.dart';

class AdvicerCubit extends Cubit<AdvicerCubitState> {
  final AdviceUseCases adviceUseCases;
  AdvicerCubit({required this.adviceUseCases}) : super(AdvicerInitial());

  void adviceRequested() async {
    emit(AdvicerStateLoading());
    final failureOrAdvice = await adviceUseCases.getAdvice();
    failureOrAdvice.fold(
      (failure) =>
          emit(AdvicerStateError(message: _mapFailureToMessage(failure))),
      (advice) => emit(AdvicerStateLoaded(advice: advice.advice)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failed';
      case CacheFailure:
        return 'Cache Failed';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
