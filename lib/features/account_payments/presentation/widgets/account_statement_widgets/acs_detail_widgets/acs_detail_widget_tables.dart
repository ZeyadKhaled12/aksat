import 'package:flutter/material.dart';

import '../../../../domain/entities/ap.dart';
import 'acs_detail_widget_expanded_table.dart';

class ACSDetailWidgetTables extends StatelessWidget {
  const ACSDetailWidgetTables({Key? key, required this.ap}) : super(key: key);
  final Ap ap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ACSDetailWidgetExpandedTable(
            title: 'الاقساط المستحقة والمدفوعة',
            isPk: false,
            isKst: true,
            billTokens: List.generate(ap.apTableAksat.rows.length,
                    (index) => ap.apTableAksat.rows[index].apTableRowBill.token),
            apToken: ap.tokenOfAp,
            dates: List.generate(ap.apTableAksat.rows.length,
                    (index) => ap.apTableAksat.rows[index].date),
            prices: List.generate(ap.apTableAksat.rows.length,
                    (index) => ap.apTableAksat.rows[index].price),
            listAksatStatus: List.generate(ap.apTableAksat.rows.length,
                    (index) => ap.apTableAksat.rows[index].aksatStatus)),
        const Padding(padding: EdgeInsets.only(bottom: 42)),
        ACSDetailWidgetExpandedTable(
            title: 'الدفعات المستحقة والمدفوعة',
            isPk: false,
            isKst: false,
            billTokens: List.generate(ap.apTablePayments.rows.length,
                    (index) => ap.apTablePayments.rows[index].apTableRowBill.token),
            apToken: ap.tokenOfAp,
            dates: List.generate(ap.apTablePayments.rows.length,
                    (index) => ap.apTablePayments.rows[index].date),
            prices: List.generate(ap.apTablePayments.rows.length,
                    (index) => ap.apTablePayments.rows[index].price),
            listAksatStatus: List.generate(ap.apTablePayments.rows.length,
                    (index) => ap.apTablePayments.rows[index].aksatStatus))
      ],
    );
  }
}
