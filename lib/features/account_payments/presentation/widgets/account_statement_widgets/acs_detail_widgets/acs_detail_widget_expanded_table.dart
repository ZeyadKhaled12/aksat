import 'package:aksat/features/add_new_contract/domain/entities/contract.dart';
import 'package:aksat/features/start/domain/entities/company.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../config/app_colors.dart';
import '../../../../../../core/utils/assets_manager.dart';
import '../../../../../../core/utils/enums.dart';

import '../../payments_aksat_widgets/pk_detail_widgets/pk_detail_widgets/pk_detail_widget_table_alert_dialog.dart';

class ACSDetailWidgetExpandedTable extends StatelessWidget {
  const ACSDetailWidgetExpandedTable({Key? key,
    required this.title,
    required this.dates,
    required this.prices,
    required this.listAksatStatus,
    this.aksatStatusShow,
    required this.isPk,
    this.requestState,
    this.company,
    required this.apToken, this.contextOfBloc, this.contract, required this.billTokens,required this.isKst})
      : super(key: key);
  final List dates;
  final List<double> prices;
  final List<String> billTokens;
  final List<AksatStatus> listAksatStatus;
  final String title;
  final bool isPk;
  final Company? company;
  final String apToken;
  final RequestState? requestState;
  final List<AksatStatus>? aksatStatusShow;
  final BuildContext? contextOfBloc;
  final Contract? contract;
  final bool isKst;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title,
          textAlign: TextAlign.right,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: FontsAssets.primaryArabicFont,
              fontWeight: FontWeight.bold)),
      children: List.generate(dates.length, (index) {
        final Widget content = rowTable(
            isPk: isPk,
            aksatLength: dates.length,
            billToken: billTokens[index],
            isKst: isKst,
            contract: contract,
            contextOfBloc: contextOfBloc,
            apToken: apToken,
            company: company,
            requestState: requestState,
            context: context,
            date: DateFormat.yMd().format(dates[index]),
            price: '${prices[index]}',
            number: '${index + 1}',
            color: listAksatStatus[index] == AksatStatus.late
                ? AppColors.filterColorRed.withOpacity(0.8)
                : listAksatStatus[index] == AksatStatus.done
                ? AppColors.filterColorGreen.withOpacity(0.8)
                : listAksatStatus[index] == AksatStatus.close
                ? AppColors.filterColorOrange.withOpacity(0.8)
                : AppColors.filterColorGrey.withOpacity(0.8));
        return aksatStatusShow != null
            ? isShow(aksatStatusShow, listAksatStatus[index])
            ? content
            : const Center()
            : content;
      }),
    );
  }
}

Widget rowTable({required String date,
  required String price,
  required String number,
  required bool isPk,
  RequestState? requestState,
  Company? company,
  required String apToken,
  Contract? contract,
  required BuildContext context,
  required String billToken,
  BuildContext? contextOfBloc,
  required int aksatLength,
  required Color color,
  required bool isKst
}) {
  return Container(
    height: 40,
    margin: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        if (isPk)
          TextButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (ctx) =>
                        PKDetailWidgetTableAlertDialog(
                          aksatLength: aksatLength,
                          isKst: isKst,
                          billToken: billToken,
                          requestState: requestState,
                          kstNum: int.parse(number),
                          company: company!,
                          contract: contract!,
                          price: double.parse(price),
                          contextOfBloc: contextOfBloc!,
                          apToken: apToken,
                        ));
              },
              child: const Text(
                'ادفع',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: FontsAssets.primaryArabicFont,
                    fontSize: 16),
              )),
        Flexible(
          child: Row(
            children: [
              rowCeilTable(date, 4, color, true),
              rowCeilTable(price, 4, color, false),
              rowCeilTable(number, 1, color, false),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget rowCeilTable(String text, int flex, Color color, bool isLast) {
  return Flexible(
    flex: flex,
    child: Container(
      margin: EdgeInsets.only(left: isLast ? 0 : 5),
      color: color,
      child: Center(
        child: Text(text,
            style: TextStyle(
                color: color == AppColors.filterColorRed.withOpacity(0.8)
                    ? Colors.white
                    : Colors.black,
                fontSize: 16,
                fontFamily: FontsAssets.secondaryArabicFont)),
      ),
    ),
  );
}

bool isShow(List<AksatStatus>? aksatStatusNotShow, AksatStatus aksatStatus) {
  for (var element in aksatStatusNotShow!) {
    if (aksatStatus == element) {
      return true;
    }
  }
  return false;
}
