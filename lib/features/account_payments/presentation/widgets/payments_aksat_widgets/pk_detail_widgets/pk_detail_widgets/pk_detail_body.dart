import 'package:flutter/material.dart';

import '../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../core/utils/enums.dart';
import '../../../../../../add_new_contract/domain/entities/contract.dart';
import '../../../../../../start/domain/entities/company.dart';
import '../../../../../domain/entities/ap.dart';
import '../../../../screens/account_statement_screens/acs_detail_screen.dart';
import '../../../account_statement_widgets/acs_detail_widgets/acs_detail_widget_data_list.dart';
import 'pk_detail_widget_tables.dart';

class PKDetailBody extends StatelessWidget {
  const PKDetailBody(
      {Key? key,
      required this.ap,
      required this.contract,
      this.requestState,
      required this.isNavigate,
      required this.company,
      required this.contextOfBloc, required this.searchBillText})
      : super(key: key);
  final Ap ap;
  final Contract contract;
  final RequestState? requestState;
  final bool isNavigate;
  final String searchBillText;
  final Company company;
  final BuildContext contextOfBloc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 55),
            child: Column(
              children: [
                ACSDetailWidgetDataList(contract: contract),
                const Padding(padding: EdgeInsets.only(bottom: 28)),
                PKDetailWidgetTables(
                    ap: ap,
                    company: company,
                    contract: contract,
                    contextOfBloc: contextOfBloc,
                    requestState: requestState),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
              ],
            ),
          ),
        ),
        if (!isNavigate)
          InkWell(
            onTap: () async => await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ACSDetailScreen(
                      company: company,
                      searchBillText: searchBillText,
                      ap: ap,
                      contract: contract,
                      isNavigate: true),
                )),
            child: Container(
              width: double.infinity,
              height: 40,
              color: Theme.of(context).primaryColor.withOpacity(0.6),
              child: const Center(
                child: Text('الذهاب الي كشف الحساب',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: FontsAssets.secondaryArabicFont,
                        fontSize: 16)),
              ),
            ),
          )
      ],
    );
  }
}
