import 'package:aksat/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../add_new_contract/presentation/widgets/anc_general_widget_table.dart';

class ACSDetailWidgetData extends StatelessWidget {
  const ACSDetailWidgetData(
      {Key? key, required this.titles, required this.values, required this.title})
      : super(key: key);
  final List<String> titles;
  final List<String> values;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ANCGeneralWidgetTable(
      title: title,
      body: Column(
        children: List.generate(titles.length,
                (index) => dot(titles[index], values[index], index == titles.length - 1))
      ),
    );
  }
}

Widget dot(String title, String value, bool isLast) {
  return Padding(
    padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.grey,
                    fontFamily: FontsAssets.secondaryArabicFont,
                    fontSize: 15),
              ),
              Text(
                value,
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: FontsAssets.secondaryArabicFont,
                    fontSize: 16),
              )
            ],
          ),
        ),
        const CircleAvatar(backgroundColor: Colors.black, radius: 4),
      ],
    ),
  );
}
