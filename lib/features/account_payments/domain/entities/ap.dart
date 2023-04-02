import 'package:aksat/core/utils/enums.dart';
import 'package:equatable/equatable.dart';

class Ap extends Equatable {
  final ApTable apTableAksat;
  final ApTable apTablePayments;
  final String tokenOfContract;
  final String tokenOfAp;

  const Ap(
      {required this.apTableAksat,
      required this.apTablePayments,
      required this.tokenOfAp,
      required this.tokenOfContract});

  @override
  List<Object> get props =>
      [apTableAksat, apTablePayments, tokenOfContract, tokenOfAp];
}

class ApTable extends Equatable {
  final List<ApTableRow> rows;

  const ApTable({required this.rows});

  @override
  List<Object> get props => [rows];
}

class ApTableRow extends Equatable {
  final DateTime date;
  final double price;
  final ApTableRowBill apTableRowBill;
  final AksatStatus aksatStatus;
  final bool isDone;

  const ApTableRow(
      {required this.date,
      required this.price,
      required this.apTableRowBill,
      required this.aksatStatus,
      required this.isDone});

  @override
  List<Object> get props => [date, price, aksatStatus, isDone, apTableRowBill];
}

class ApTableRowBill extends Equatable {
  final DateTime? date;
  final String token;

  const ApTableRowBill({this.date, required this.token});

  @override
  List<Object> get props => [token];
}
