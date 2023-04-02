import 'package:aksat/features/account_payments/data/models/ap_table_row_model.dart';

import '../../domain/entities/ap.dart';
import 'ap_table_model.dart';

class ApModel extends Ap {
  const ApModel(
      {required ApTable apTableAksat,
      required ApTable apTablePayments,
      required String tokenOfAp,
      required String tokenOfContract})
      : super(
            apTableAksat: apTableAksat,
            tokenOfAp: tokenOfAp,
            apTablePayments: apTablePayments,
            tokenOfContract: tokenOfContract);


  factory ApModel.fromJson(Map<String, dynamic> json, String tokenOfAp) => ApModel(
    apTableAksat: ApTableModel.fromJson(json['table_aksat']),
    tokenOfAp: tokenOfAp,
    apTablePayments: ApTableModel.fromJson(json['table_payments']),
        tokenOfContract: json['token_contract'],
      );

  void updateTableAksat(int index, ApTableRowModel apTableRowModel){
    apTableAksat.rows[index] = apTableRowModel;
  }
  void updateTablePayments(int index, ApTableRowModel apTableRowModel){
    apTablePayments.rows[index] = apTableRowModel;
  }

  Map<String, dynamic> toJson() => {
        'table_aksat': (apTableAksat as ApTableModel).toJson(),
        'table_payments': (apTablePayments as ApTableModel).toJson(),
        'token_contract': tokenOfContract
      };

}
