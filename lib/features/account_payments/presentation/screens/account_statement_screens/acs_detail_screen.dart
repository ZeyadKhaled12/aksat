import 'package:aksat/core/utils/assets_manager.dart';
import 'package:aksat/features/start/domain/entities/company.dart';
import 'package:flutter/material.dart';
import '../../../../add_new_contract/domain/entities/contract.dart';
import '../../../domain/entities/ap.dart';
import '../../widgets/account_statement_widgets/acs_detail_widgets/acs_detail_widget_convert_to_pdf.dart';
import '../../widgets/account_statement_widgets/acs_detail_widgets/acs_detail_widget_data_list.dart';
import '../../widgets/account_statement_widgets/acs_detail_widgets/acs_detail_widget_instructions.dart';
import '../../widgets/account_statement_widgets/acs_detail_widgets/acs_detail_widget_tables.dart';
import '../payments_aksat _screen/pk_detail_screen.dart';

class ACSDetailScreen extends StatelessWidget {
  const ACSDetailScreen(
      {Key? key,
      required this.ap,
      required this.contract,
      this.isNavigate = false,
      required this.company,
      required this.searchBillText})
      : super(key: key);
  final Ap ap;
  final Contract contract;
  final bool isNavigate;
  final String searchBillText;
  final Company company;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
          child: AppBar(backgroundColor: Colors.black),
          preferredSize: const Size.fromHeight(0)),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 55),
              child: Column(
                children: [
                  const ACSDetailWidgetInstructions(),
                  ACSDetailWidgetDataList(contract: contract),
                  const Padding(padding: EdgeInsets.only(bottom: 28)),
                  ACSDetailWidgetTables(ap: ap),
                  const Padding(padding: EdgeInsets.only(bottom: 28)),
                  const ACSDetailWidgetConvertToPdf()
                ],
              ),
            ),
          ),
          if (!isNavigate)
            InkWell(
              onTap: () async => await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => PKDetailScreen(
                        company: company,
                        contextOfBloc: context,
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
                  child: Text('الذهاب الي تسديد القسط',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontsAssets.secondaryArabicFont,
                          fontSize: 16)),
                ),
              ),
            )
        ],
      ),
    );
  }
}
