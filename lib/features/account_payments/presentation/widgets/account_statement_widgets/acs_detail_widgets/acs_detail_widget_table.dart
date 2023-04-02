import 'package:aksat/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../config/app_colors.dart';
import '../../../../../../core/utils/assets_manager.dart';


class ACSDetailWidgetTable extends StatelessWidget {
  const ACSDetailWidgetTable(
      {Key? key,
      required this.dates,
      required this.prices,
      required this.aksatStatus, required this.title})
      : super(key: key);
  final List dates;
  final List<double> prices;
  final List<AksatStatus> aksatStatus;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 1/2.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(title, style: const TextStyle(color: Colors.black,
            fontSize: 20,
            fontFamily: FontsAssets.primaryArabicFont,
            fontWeight: FontWeight.bold
          )),
          const Padding(padding: EdgeInsets.only(bottom: 8)),
          rowTable(
              date: 'تاريخ',
              price: 'قيمة (جنيه)',
              number: 'رقم',
              color: Theme.of(context).primaryColor.withOpacity(0.4)),
          Flexible(
            child: ListView.builder(
              itemCount: dates.length,
              itemBuilder: (context, index) => rowTable(
                  date: DateFormat.yMd().format(dates[index]),
                  price: '${prices[index]}',
                  number: '${index + 1}',
                  color: aksatStatus[index] == AksatStatus.late
                      ? AppColors.filterColorRed.withOpacity(0.8)
                      : aksatStatus[index] == AksatStatus.done
                          ? AppColors.filterColorGreen.withOpacity(0.8)
                          : aksatStatus[index] == AksatStatus.close
                              ? AppColors.filterColorOrange.withOpacity(0.8)
                              : AppColors.filterColorGrey.withOpacity(0.8)),
            ),
          )
        ],
      ),
    );
  }
}

Widget rowTable(
    {required String date,
    required String price,
    required String number,
    required Color color}) {
  return Container(
    height: 40,
    margin: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        rowCeilTable(date, 4, color, true),
        rowCeilTable(price, 4, color, false),
        rowCeilTable(number, 1, color, false),
      ],
    ),
  );
}

Widget rowCeilTable(String text, int flex, Color color, bool isLast) {
  return Flexible(
    flex: flex,
    child: Container(
      margin: EdgeInsets.only(left: isLast?0:5),
      color: color,
      child: Center(
        child: Text(text,
            style: TextStyle(
                color: color == AppColors.filterColorRed.withOpacity(0.8)
                    ? Colors.white
                    : Colors.black,
                fontSize: 16,
                fontFamily: FontsAssets.secondaryArabicFont)),
      ),
    ),
  );
}
