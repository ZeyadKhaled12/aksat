import 'package:aksat/features/add_new_contract/domain/entities/extra.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExtraModel extends Extra {
  const ExtraModel({required double price, required DateTime date})
      : super(price: price, date: date);

  factory ExtraModel.fromJson(Map<String, dynamic> json) => ExtraModel(
     date: (json['date'] as Timestamp).toDate(),
      price: json['price']
  );

  Map<String, dynamic> toJson() => {
    'date': date,
    'price': price,
  };
}
