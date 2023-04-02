import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager.dart';

class ANCGeneralWidgetTable extends StatelessWidget {
  const ANCGeneralWidgetTable(
      {Key? key, required this.body, required this.title})
      : super(key: key);
  final Widget body;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey, width: 2),
              ),
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(top: 14),
              child: body),
          Container(
            margin: const EdgeInsets.only(right: 38),
            padding: const EdgeInsets.only(left: 20, right: 20),
            color: Theme.of(context).colorScheme.background,
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: FontsAssets.secondaryArabicFont),
            ),
          ),
        ],
      ),
    );
  }
}
