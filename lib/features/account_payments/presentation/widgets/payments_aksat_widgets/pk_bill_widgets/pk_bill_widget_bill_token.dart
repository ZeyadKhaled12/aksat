import 'package:flutter/material.dart';

import '../../../../../../core/utils/assets_manager.dart';

class PKBillWidgetBillToken extends StatelessWidget {
  const PKBillWidgetBillToken(
      {Key? key,
      required this.aksatLength,
      required this.kstNum,
      required this.token, required this.isKst})
      : super(key: key);
  final int aksatLength;
  final int kstNum;
  final String token;
  final bool isKst;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        text('ايصال استلام نقدية/شيك', Colors.black),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            text(isKst?'اقساط':'دفعات', Colors.red),
            text(' $aksatLength ', Colors.red),
            text('من', Colors.red),
            text(' $kstNum ', Colors.red),
            text(isKst?'القسط رقم':'الدفعة رقم', Colors.red),
          ],
        ),
        text(token, Colors.red)
      ],
    );
  }
}

Text text(String text, Color color) {
  return Text(text,
      style: TextStyle(
          color: color,
          fontSize: 20,
          fontFamily: FontsAssets.secondaryArabicFont));
}
