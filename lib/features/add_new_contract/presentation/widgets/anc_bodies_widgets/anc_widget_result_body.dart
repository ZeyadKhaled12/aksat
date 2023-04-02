import 'package:aksat/core/utils/assets_manager.dart';
import 'package:aksat/core/utils/general_functions.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/contract.dart';

class ANCWidgetResultBody extends StatelessWidget {
  const ANCWidgetResultBody({Key? key, required this.contract})
      : super(key: key);
  final Contract contract;

  @override
  Widget build(BuildContext context) {
    GeneralFunctions generalFunctions = GeneralFunctions();
    PriceAksatNumberOfKstKstDuration priceAksatNumberOfKstKstDuration =
        generalFunctions.getPriceAksatNumberOfKstKstDuration(
            contract: contract);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          sentenceAndAmount(
              sentence: 'مبلغ الاقساط',
              amount: priceAksatNumberOfKstKstDuration.priceAksat,
              unit: 'جنيه'),
          sentenceAndAmount(
              sentence: 'عدد الاقساط',
              amount: priceAksatNumberOfKstKstDuration.numberOfKst <= 0
                  ? 0
                  : priceAksatNumberOfKstKstDuration.numberOfKst,
              unit: 'قسط'),
          sentenceAndAmount(
              sentence: 'مدة القسط',
              amount: priceAksatNumberOfKstKstDuration.numberOfKst <= 0
                  ? 0
                  : priceAksatNumberOfKstKstDuration.kstDuration,
              unit: 'شهر'),
        ],
      ),
    );
  }
}

Widget sentenceAndAmount(
    {required String sentence, required double amount, required String unit}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(unit,
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: FontsAssets.secondaryArabicFont,
                    fontSize: 18)),
            Text(' $amount',
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: FontsAssets.secondaryArabicFont,
                    fontSize: 18)),
          ],
        ),
        Text(sentence,
            style: const TextStyle(
                color: Colors.grey,
                fontFamily: FontsAssets.secondaryArabicFont,
                fontSize: 15)),
      ],
    ),
  );
}
