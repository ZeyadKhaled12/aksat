import 'package:aksat/core/utils/enums.dart';
import 'package:equatable/equatable.dart';

import 'extra.dart';

class Contract extends Equatable {
  final String customerName;
  final String phoneNumber;
  final String productType;
  final double totalPrice;
  final double paidUpPrice;
  final double valueOfKst;
  final int kstSystem;
  final DateTime? startDate;
  final List<Extra> extras;
  final AksatStatus? aksatStatus;

  const Contract(
      {required this.customerName,
      required this.phoneNumber,
      required this.extras,
      required this.productType,
      required this.totalPrice,
      required this.paidUpPrice,
      required this.valueOfKst,
      this.aksatStatus,
      required this.kstSystem,
      this.startDate});

  @override
  List<Object> get props => [
        customerName,
        phoneNumber,
        extras,
        productType,
        totalPrice,
        paidUpPrice,
        valueOfKst,
        kstSystem,
      ];
}
