import 'package:flutter/material.dart';

import '../../../../../../core/utils/assets_manager.dart';

class PKBillWidgetComp extends StatelessWidget {
  const PKBillWidgetComp(
      {Key? key, required this.companyName, required this.phoneNumber, required this.isKst})
      : super(key: key);
  final String companyName;
  final String phoneNumber;
  final bool isKst;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            text(isKst?'قيمة القسط':'قيمة الدفعة', Colors.black),
            const Padding(padding: EdgeInsets.only(left: 5)),
            text('جنيه', Colors.black),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                text(companyName, Colors.black),
                const Padding(padding: EdgeInsets.only(left: 5)),
                text('شركة', Colors.black),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                text('$phoneNumber /', Colors.black),
                const Padding(padding: EdgeInsets.only(left: 5)),
                text('ت', Colors.black)
              ],
            )
          ],
        ),
      ],
    );
  }
}

Text text(String text, Color color) {
  return Text(text,
      style: TextStyle(
          color: color,
          fontSize: 18,
          fontFamily: FontsAssets.secondaryArabicFont));
}
