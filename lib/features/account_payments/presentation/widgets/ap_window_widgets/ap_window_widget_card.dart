import 'package:aksat/core/utils/enums.dart';
import 'package:aksat/features/start/domain/entities/company.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../config/app_colors.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../add_new_contract/domain/entities/contract.dart';
import '../../../domain/entities/ap.dart';
import '../../screens/account_statement_screens/acs_detail_screen.dart';
import '../../screens/payments_aksat _screen/pk_detail_screen.dart';

class APWindowWidgetCard extends StatelessWidget {
  const APWindowWidgetCard({
    Key? key,
    required this.contract,
    required this.ap,
    required this.searchText,
    required this.isPk,
    this.requestState,
    required this.company,
    required this.searchBillText,
  }) : super(key: key);
  final Contract contract;
  final Ap ap;
  final RequestState? requestState;
  final String searchText;
  final String searchBillText;
  final bool isPk;
  final Company company;

  @override
  Widget build(BuildContext context) {
    String status = isPk
        ? ''
        : contract.aksatStatus == AksatStatus.late
            ? 'عليه اقساط متأخرة'
            : contract.aksatStatus == AksatStatus.done
                ? 'مسدد جميع الاقساط حتي الان'
                : 'عليه اقساط قادمة';

    if (isPk) {
      for (int i = 0; i < ap.apTableAksat.rows.length; i++) {
        if (!ap.apTableAksat.rows[i].isDone) {
          status =
              'ميعاد القسط القادم\n${DateFormat.yMd().format(ap.apTableAksat.rows[i].date)}';
          break;
        }
      }
    }

    Color color = contract.aksatStatus == AksatStatus.late
        ? AppColors.filterColorRed.withOpacity(0.6)
        : contract.aksatStatus == AksatStatus.done
            ? AppColors.filterColorGreen.withOpacity(0.6)
            : AppColors.filterColorOrange.withOpacity(0.6);

    return body(
        context: context,
        ap: ap,
        searchTextBill: searchBillText,
        company: company,
        isPk: isPk,
        requestState: requestState,
        contract: contract,
        status: status,
        color: color);
  }
}

Widget body(
    {required BuildContext context,
    required Ap ap,
    required Contract contract,
    required String status,
    required bool isPk,
    required Company company,
    RequestState? requestState,
    required String searchTextBill,
    required Color color}) {
  return InkWell(
    onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => isPk
              ? PKDetailScreen(
                  contract: contract,
                  searchBillText: searchTextBill,
                  contextOfBloc: context,
                  ap: ap,
                  requestState: requestState,
                  company: company,
                )
              : ACSDetailScreen(
                  ap: ap,
                  searchBillText: searchTextBill,
                  contract: contract,
                  company: company),
        )),
    child: Container(
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  row(contract.customerName, Icons.person),
                  row(contract.phoneNumber, Icons.phone),
                  row(contract.productType, Icons.category),
                ],
              ),
            ),
          ),
          Container(
            height: 58,
            padding: const EdgeInsets.all(5),
            width: double.infinity,
            decoration: BoxDecoration(color: color),
            child: Center(
              child: Text(
                status,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: contract.aksatStatus == AksatStatus.late
                        ? Colors.white
                        : Colors.black,
                    fontFamily: FontsAssets.secondaryArabicFont),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Center(
              child: Text('قيمة القسط: ${contract.valueOfKst} جنيه',
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: FontsAssets.secondaryArabicFont),
                  textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget row(String text, IconData iconData) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5, right: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: FontsAssets.secondaryArabicFont),
          ),
        ),
        const Padding(padding: EdgeInsets.only(right: 5)),
        Icon(iconData, color: Colors.black)
      ],
    ),
  );
}
