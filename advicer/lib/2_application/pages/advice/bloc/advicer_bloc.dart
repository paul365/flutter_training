import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  AdvicerBloc() : super(AdvicerInitial()) {
    on<AdviceRequested>((event, emit) async {
      emit(AdvicerStateLoading());
      debugPrint('fake get advice');
      await Future.delayed(Duration(seconds: 3), () {});
      debugPrint('advice loaded');
      emit(AdvicerStateLoaded(advice: 'fake advice'));
    });
  }
}
