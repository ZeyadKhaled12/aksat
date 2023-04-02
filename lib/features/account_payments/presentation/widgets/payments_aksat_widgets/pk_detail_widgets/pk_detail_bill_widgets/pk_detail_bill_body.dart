import 'package:aksat/features/start/domain/entities/company.dart';
import 'package:flutter/material.dart';
import '../../../../../../add_new_contract/domain/entities/contract.dart';
import '../../../../../domain/entities/ap.dart';
import 'pk_detail_widget_bill_card.dart';
import 'pk_detail_widget_bill_search.dart';

class PKDetailBillBody extends StatelessWidget {
  const PKDetailBillBody({Key? key,
    required this.ap,
    required this.contract,
    required this.company,
    required this.contextOfBloc, required this.searchBillText})
      : super(key: key);
  final Ap ap;
  final Contract contract;
  final Company company;
  final String searchBillText;
  final BuildContext contextOfBloc;

  @override
  Widget build(BuildContext context) {
    List<ApTableRowBill> billsList = [];
    List<bool> isAksatList = [];
    List<double> pricesList = [];
    List<int> kstNumList = [];
    int index = 0;
    for (var element in ap.apTableAksat.rows) {
      billsList.add(element.apTableRowBill);
      isAksatList.add(true);
      pricesList.add(element.price);
      kstNumList.add(index + 1);
      index++;
    }
    index = 0;
    for (var element in ap.apTablePayments.rows) {
      billsList.add(element.apTableRowBill);
      isAksatList.add(false);
      pricesList.add(element.price);
      kstNumList.add(index + 1);
      index++;
    }

    index = 0;
    while (index < billsList.length) {
      if (billsList[index].date == null) {
        billsList.removeAt(index);
        isAksatList.removeAt(index);
        pricesList.removeAt(index);
        kstNumList.removeAt(index);
      } else {
        index++;
      }
    }

    index = 0;
    if (searchBillText.isNotEmpty) {
      while (index < billsList.length) {
        if (billsList[index].token != searchBillText) {
          billsList.removeAt(index);
          isAksatList.removeAt(index);
          pricesList.removeAt(index);
          kstNumList.removeAt(index);
        } else {
          index++;
        }
      }
    }

    print(searchBillText);
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.only(left: 10, right: 10),
      color: Theme
          .of(context)
          .colorScheme
          .background,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(
                  right: 10, left: 10, bottom: 25, top: 20),
              child: PKDetailWidgetBillSearch(contextOfBloc: contextOfBloc)),
          Flexible(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: MediaQuery
                  .of(context)
                  .size
                  .width / 230,
              shrinkWrap: true,
              children: List.generate(billsList.length, (index) {
                return PKDetailWidgetBillCard(
                  apTableRowBill: billsList[index],
                  company: company,
                  contract: contract,
                  isKst: isAksatList[index],
                  price: pricesList[index],
                  kstNum: kstNumList[index],
                  paymentsLength: ap.apTablePayments.rows.length,
                  aksatLength: ap.apTableAksat.rows.length,
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}