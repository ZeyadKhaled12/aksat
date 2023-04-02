import 'package:aksat/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../add_new_contract/domain/entities/contract.dart';
import '../../../../../../start/domain/entities/company.dart';
import '../../../../../domain/entities/ap.dart';
import '../../../../screens/payments_aksat _screen/pk_bill_screen.dart';

class PKDetailWidgetBillCard extends StatelessWidget {
  const PKDetailWidgetBillCard(
      {Key? key,
      required this.apTableRowBill,
      required this.company,
      required this.contract,
      required this.isKst,
      required this.price,
      required this.aksatLength,
      required this.kstNum, required this.paymentsLength})
      : super(key: key);
  final ApTableRowBill apTableRowBill;
  final Company company;
  final Contract contract;
  final bool isKst;
  final double price;
  final int aksatLength;
  final int paymentsLength;
  final int kstNum;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PKBillScreen(
                company: company,
                contract: contract,
                price: price,
                token: apTableRowBill.token,
                aksatLength: isKst?aksatLength:paymentsLength,
                kstNum: kstNum,
                isKst: isKst),
          )),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(apTableRowBill.token,
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Text(
              DateFormat.yMd().format(apTableRowBill.date!),
              style: const TextStyle(
                color: Colors.black,
                fontFamily: FontsAssets.primaryArabicFont,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
