import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/assets_manager.dart';

class PKBillWidgetDate extends StatelessWidget {
  const PKBillWidgetDate({Key? key, required this.dateTime}) : super(key: key);
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        text(DateFormat('y/M/d').format(dateTime), Colors.black),
        const Padding(padding: EdgeInsets.only(left: 5)),
        text('تاريخ:', Colors.black),
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
