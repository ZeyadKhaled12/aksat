import 'package:aksat/core/utils/assets_manager.dart';
import 'package:aksat/core/utils/enums.dart';
import 'package:aksat/features/start/domain/entities/company.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../add_new_contract/domain/entities/contract.dart';
import '../../../../../domain/usecases/pay_uc.dart';
import '../../../../controller/account_payments_bloc.dart';
import '../../../../screens/payments_aksat _screen/pk_bill_screen.dart';

class PKDetailWidgetTableAlertDialog extends StatelessWidget {
  const PKDetailWidgetTableAlertDialog(
      {Key? key,
      this.requestState,
      required this.company,
      required this.apToken,
      required this.contextOfBloc,
      required this.kstNum,
      required this.contract,
      required this.price,
      required this.aksatLength,
      required this.billToken, required this.isKst})
      : super(key: key);
  final RequestState? requestState;
  final Company company;
  final Contract contract;
  final String apToken;
  final BuildContext contextOfBloc;
  final int kstNum;
  final double price;
  final int aksatLength;
  final String billToken;
  final bool isKst;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text('هل تريد تأكيد الدفع',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: FontsAssets.primaryArabicFont),
          textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (requestState == RequestState.loading)
            CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button(context, () => Navigator.pop(context), 'لا'),
              const Padding(padding: EdgeInsets.only(left: 20)),
              button(context, () async{
                contextOfBloc.read<AccountStatementBloc>().add(PayEvent(
                    payParameters: PayParameters(
                        companyToken: company.token,
                        index: kstNum - 1,
                        apToken: apToken,
                        isKst: isKst)));
                if (requestState == RequestState.loaded) {
                  Navigator.pop(context);
                  await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PKBillScreen(
                          company: company,
                          contract: contract,
                          isKst: isKst,
                          price: price,
                          kstNum: kstNum,
                          token: billToken,
                          aksatLength: aksatLength,
                        ),
                      ));
                }
              }, 'نعم'),
            ],
          ),
        ],
      ),
    );
  }
}

Widget button(BuildContext context, Function() fun, String text) {
  return Expanded(
    child: ElevatedButton(
        onPressed: fun,
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: FontsAssets.secondaryArabicFont),
        )),
  );
}
