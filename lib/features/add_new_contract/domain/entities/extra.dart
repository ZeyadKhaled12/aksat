import 'package:equatable/equatable.dart';

class Extra extends Equatable {
  final double price;
  final DateTime date;

  const Extra({required this.price,
    required this.date});

  @override
  List<Object> get props => [price, date];
}