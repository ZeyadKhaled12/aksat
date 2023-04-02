import 'package:aksat/core/utils/enums.dart';
import 'package:aksat/features/add_new_contract/domain/entities/contract.dart';
import 'package:aksat/features/start/domain/entities/company.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/entities/ap.dart';
import '../../../account_statement_widgets/acs_detail_widgets/acs_detail_widget_expanded_table.dart';

class PKDetailWidgetTables extends StatelessWidget {
  const PKDetailWidgetTables(
      {Key? key,
      required this.ap,
      this.requestState,
      required this.company,
      this.contextOfBloc,
      required this.contract})
      : super(key: key);
  final Ap ap;
  final RequestState? requestState;
  final Company company;
  final Contract contract;
  final BuildContext? contextOfBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ACSDetailWidgetExpandedTable(
            title: 'الاقساط الغير مدفوعة',
            requestState: requestState,
            apToken: ap.tokenOfAp,
            contextOfBloc: contextOfBloc,
            contract: contract,
            company: company,
            isKst: true,
            isPk: true,
            billTokens: List.generate(ap.apTableAksat.rows.length,
                (index) => ap.apTableAksat.rows[index].apTableRowBill.token),
            aksatStatusShow: const [AksatStatus.close],
            dates: List.generate(ap.apTableAksat.rows.length,
                (index) => ap.apTableAksat.rows[index].date),
            prices: List.generate(ap.apTableAksat.rows.length,
                (index) => ap.apTableAksat.rows[index].price),
            listAksatStatus: List.generate(ap.apTableAksat.rows.length,
                (index) => ap.apTableAksat.rows[index].aksatStatus)),
        const Padding(padding: EdgeInsets.only(bottom: 42)),
        ACSDetailWidgetExpandedTable(
            title: 'الاقساط المتأخرة',
            contract: contract,
            company: company,
            apToken: ap.tokenOfAp,
            contextOfBloc: contextOfBloc,
            isPk: true,
            isKst: true,
            billTokens: List.generate(ap.apTableAksat.rows.length,
                (index) => ap.apTableAksat.rows[index].apTableRowBill.token),
            requestState: requestState,
            aksatStatusShow: const [AksatStatus.late],
            dates: List.generate(ap.apTableAksat.rows.length,
                (index) => ap.apTableAksat.rows[index].date),
            prices: List.generate(ap.apTableAksat.rows.length,
                (index) => ap.apTableAksat.rows[index].price),
            listAksatStatus: List.generate(ap.apTableAksat.rows.length,
                (index) => ap.apTableAksat.rows[index].aksatStatus)),
        const Padding(padding: EdgeInsets.only(bottom: 42)),
        ACSDetailWidgetExpandedTable(
            title: 'الدفعات الغير مدفوعة',
            isPk: true,
            isKst: false,
            contract: contract,
            billTokens: List.generate(ap.apTablePayments.rows.length,
                (index) => ap.apTablePayments.rows[index].apTableRowBill.token),
            company: company,
            contextOfBloc: contextOfBloc,
            apToken: ap.tokenOfAp,
            requestState: requestState,
            aksatStatusShow: const [
              AksatStatus.late,
              AksatStatus.close,
            ],
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
