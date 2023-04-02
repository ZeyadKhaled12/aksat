import 'package:aksat/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

import '../../../../add_new_contract/domain/entities/contract.dart';
import '../../../../start/domain/entities/company.dart';
import '../../widgets/payments_aksat_widgets/pk_bill_widgets/pk_bill_widget_bill_token.dart';
import '../../widgets/payments_aksat_widgets/pk_bill_widgets/pk_bill_widget_body.dart';
import '../../widgets/payments_aksat_widgets/pk_bill_widgets/pk_bill_widget_btns.dart';
import '../../widgets/payments_aksat_widgets/pk_bill_widgets/pk_bill_widget_comp.dart';
import '../../widgets/payments_aksat_widgets/pk_bill_widgets/pk_bill_widget_date.dart';

class PKBillScreen extends StatelessWidget {
  const PKBillScreen(
      {Key? key,
      required this.company,
      required this.contract,
      required this.price,
      required this.token,
      required this.aksatLength,
      required this.kstNum,
      required this.isKst})
      : super(key: key);
  final Company company;
  final Contract contract;
  final double price;
  final String token;
  final int aksatLength;
  final int kstNum;
  final bool isKst;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        elevation: 0,
        title: const Text('فاتورة الكترونية',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: FontsAssets.primaryArabicFont,
                fontWeight: FontWeight.bold)),
      ),
      body: Container(
          color: Theme.of(context).colorScheme.background,
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PKBillWidgetComp(
                  companyName: company.companyName,
                  isKst: isKst,
                  phoneNumber: company.phoneNumber),
              PKBillWidgetBillToken(
                  aksatLength: aksatLength,
                  kstNum: kstNum,
                  isKst: isKst,
                  token: token),
              PKBillWidgetBody(
                  customerName: contract.customerName, price: price),
              PKBillWidgetDate(dateTime: DateTime.now()),
              const PKBillWidgetBtns(),
            ],
          )),
    );
  }
}
