import 'package:flutter/material.dart';

import '../../../../../../core/utils/assets_manager.dart';

class PKBillWidgetBody extends StatelessWidget {
  const PKBillWidgetBody(
      {Key? key, required this.customerName, required this.price})
      : super(key: key);
  final String customerName;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  text(customerName, Colors.black),
                  text('$price', Colors.black),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                text(' /استلمت من السيد', Colors.black),
                text(' /مبلغ وقدره', Colors.black),
              ],
            ),
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
