import 'package:aksat/core/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/ap.dart';

class ApTableRowModel extends ApTableRow {
  const ApTableRowModel(
      {required DateTime date,
      required double price,
      required ApTableRowBill apTableRowBill,
      required AksatStatus aksatStatus,
      required bool isDone})
      : super(
            date: date,
            price: price,
            apTableRowBill: apTableRowBill,
            aksatStatus: aksatStatus,
            isDone: isDone);

  factory ApTableRowModel.fromJson(Map<String, dynamic> json) {
    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inHours / 24).round();
    }

    AksatStatus getAksatStatus(DateTime dateTime) {
      DateTime dateTimeNow = DateTime.now();
      int days = daysBetween(dateTimeNow, dateTime);

      if (days < 0) {
        return AksatStatus.late;
      } else if (days <= 5) {
        return AksatStatus.close;
      }
      return AksatStatus.normal;
    }

    return ApTableRowModel(
        apTableRowBill: ApTableRowBillModel.fromJson(json['bill']),
        aksatStatus: json['is_done']
            ? AksatStatus.done
            : getAksatStatus((json['date'] as Timestamp).toDate()),
        isDone: json['is_done'],
        price: json['price'].runtimeType == int
            ? (json['price'] as int).toDouble()
            : json['price'],
        date: (json['date'] as Timestamp).toDate());
  }

  Map<String, dynamic> toJson() => {
        'is_done': isDone,
        'price': price,
        'date': date,
        'bill': ApTableRowBillModel(
            token: apTableRowBill.token, date: apTableRowBill.date).toJson()
      };
}

class ApTableRowBillModel extends ApTableRowBill {
  const ApTableRowBillModel({DateTime? date, required String token})
      : super(date: date, token: token);

  factory ApTableRowBillModel.fromJson(Map<String, dynamic> json) =>
      ApTableRowBillModel(date:(json['date'] as Timestamp?)?.toDate(), token: json['token']);

  Map<String, dynamic> toJson() => {'date': date, 'token': token};
}
