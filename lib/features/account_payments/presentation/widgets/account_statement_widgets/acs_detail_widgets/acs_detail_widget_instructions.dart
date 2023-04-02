import 'package:aksat/config/app_colors.dart';
import 'package:aksat/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

class ACSDetailWidgetInstructions extends StatelessWidget {
  const ACSDetailWidgetInstructions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          instructionWidget('تم تسديده', AppColors.filterColorGreen),
          instructionWidget('القسط المقبل المراد تسديده', AppColors.filterColorOrange),
          instructionWidget('قسط متأخر', AppColors.filterColorRed),
        ],
      ),
    );
  }
}

Widget instructionWidget(String text, Color color){
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(text, style: const TextStyle(color: Colors.black, fontFamily: FontsAssets.secondaryArabicFont,
            fontSize: 18
        ),),
        const Padding(padding: EdgeInsets.only(right: 20)),
        CircleAvatar(backgroundColor: color, radius: 15),

      ],
    ),
  );
}
