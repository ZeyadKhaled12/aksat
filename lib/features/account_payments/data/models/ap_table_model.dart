import '../../domain/entities/ap.dart';
import 'ap_table_row_model.dart';

class ApTableModel extends ApTable {
  const ApTableModel({required List<ApTableRow> rows}) : super(rows: rows);

  factory ApTableModel.fromJson(Map<String, dynamic> json) => ApTableModel(
      rows: List<ApTableRow>.from(
          (json['rows'] as List).map((e) => ApTableRowModel.fromJson(e))));

  Map<String, dynamic> toJson() => {
        'rows': List.from((rows).map((e) => ApTableRowModel(
            date: e.date,
            price: e.price,
            apTableRowBill: e.apTableRowBill,
            aksatStatus: e.aksatStatus,
            isDone: e.isDone).toJson())),
      };
}
