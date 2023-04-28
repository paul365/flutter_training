import 'package:advicer/1_domain/entities/advice_entity.dart';
import 'package:equatable/equatable.dart';

class AdviceModel extends AdviceEntity with EquatableMixin {
  final String advice;
  final int id;

  AdviceModel({
    required this.advice,
    required this.id,
  }) : super(advice: advice, id: id);

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
      advice: json['advice'],
      id: json['advice_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'advice': advice,
      'advice_id': id,
    };
  }

  @override
  List<Object?> get props => [advice, id];
}
