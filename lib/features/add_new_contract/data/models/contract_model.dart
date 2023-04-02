
import 'package:aksat/core/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/contract.dart';
import '../../domain/entities/extra.dart';
import 'extra_model.dart';

class ContractModel extends Contract {
  const ContractModel(
      {required String customerName,
      required String phoneNumber,
      required List<Extra> extras,
      required String productType,
      required double totalPrice,
      required double paidUpPrice,
      required double valueOfKst,
      required int kstSystem,
      AksatStatus? aksatStatus,
      required DateTime startDate})
      : super(
            customerName: customerName,
            phoneNumber: phoneNumber,
            extras: extras,
            aksatStatus: aksatStatus,
            productType: productType,
            totalPrice: totalPrice,
            paidUpPrice: paidUpPrice,
            valueOfKst: valueOfKst,
            kstSystem: kstSystem,
            startDate: startDate);


  factory ContractModel.fromJson(Map<String, dynamic> json, {AksatStatus? aksatStatus}) => ContractModel(
    phoneNumber: json['phone_number'],
    customerName: json['customer_name'],
    kstSystem: json['kst_system'],
    paidUpPrice: json['paid_up_price'],
    productType: json['product_type'],
    startDate: (json['start_date'] as Timestamp).toDate(),
    totalPrice: json['total_price'],
    aksatStatus: aksatStatus,
    valueOfKst: json['value_of_kst'],
    extras: List<Extra>.from(
        (json['extras'] as List).map((e) => ExtraModel.fromJson(e)))
  );

  Map<String, dynamic> toJson() => {
    'phone_number': phoneNumber,
    'customer_name': customerName,
    'kst_system': kstSystem,
    'paid_up_price': paidUpPrice,
    'product_type': productType,
    'start_date': startDate,
    'total_price': totalPrice,
    'value_of_kst': valueOfKst,
    'extras': _convertExtrasToJson(extras)
  };

  List<Map<String, dynamic>> _convertExtrasToJson(List<Extra> extras) {
    List<Map<String, dynamic>> extras = [];
    for (var e in this.extras) {
      extras.add(ExtraModel(price: e.price, date: e.date).toJson());}
    return extras;
  }
}
