import 'package:aksat/core/utils/assets_manager.dart';
import 'package:aksat/features/start/domain/entities/company.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../add_new_contract/domain/entities/contract.dart';
import '../../../../start/presentation/widgets/home_widgets/home_widget_search.dart';
import '../../../domain/entities/ap.dart';
import 'ap_window_widget_card.dart';
import 'ap_window_widget_filters_btns.dart';

class APWindowBody extends StatelessWidget {
  const APWindowBody(
      {Key? key,
      required this.listContracts,
      required this.listAp,
      this.isLoading = false,
      required this.filtersAksatStatus,
      required this.searchText,
      this.isPk = false,
      this.requestState,
      required this.company,
      required this.searchBillText})
      : super(key: key);
  final List<Contract> listContracts;
  final String searchText;
  final String searchBillText;
  final List<Ap> listAp;
  final bool isLoading;
  final AksatStatus filtersAksatStatus;
  final bool isPk;
  final Company company;
  final RequestState? requestState;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var index = 0;

    List<Contract> listContractsUpdated = List.from(listContracts);

    index = 0;
    if (filtersAksatStatus == AksatStatus.done && !isPk) {
      while (index < listContractsUpdated.length) {
        if (listContractsUpdated[index].aksatStatus != AksatStatus.done) {
          listContractsUpdated.removeAt(index);
        } else {
          index++;
        }
      }
    } else if (filtersAksatStatus == AksatStatus.close) {
      while (index < listContractsUpdated.length) {
        if (listContractsUpdated[index].aksatStatus != AksatStatus.close) {
          listContractsUpdated.removeAt(index);
        } else {
          index++;
        }
      }
    } else if (filtersAksatStatus == AksatStatus.late) {
      while (index < listContractsUpdated.length) {
        if (listContractsUpdated[index].aksatStatus != AksatStatus.late) {
          listContractsUpdated.removeAt(index);
        } else {
          index++;
        }
      }
    }

    if (searchText.isNotEmpty) {
      index = 0;
      while (index < listContractsUpdated.length) {
        if (!(listContractsUpdated[index].customerName.contains(searchText) ||
            listContractsUpdated[index].productType.contains(searchText))) {
          listContractsUpdated.removeAt(index);
        } else {
          index++;
        }
      }
    }

    return Stack(
      children: [
        listContractsUpdated.isEmpty
            ? Center(
                child: Text(
                  isPk
                      ? 'لا توجد اقساط او دفعات للتسديد حاليا'
                      : 'لا توجد عقود او بيعات حاليا',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: FontsAssets.primaryArabicFont),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: HomeWidgetSearch()),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    APWindowWidgetFiltersBtns(isPk: isPk),
                    const Padding(padding: EdgeInsets.only(bottom: 20)),
                    Flexible(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: size.width / 480,
                        shrinkWrap: true,
                        children:
                            List.generate(listContractsUpdated.length, (index) {
                          return APWindowWidgetCard(
                            isPk: isPk,
                            searchBillText: searchBillText,
                            company: company,
                            requestState: requestState,
                            ap: listAp[index],
                            searchText: searchText,
                            contract: listContractsUpdated[index],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
        if (isLoading)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white.withOpacity(0.8),
            child: Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor)),
            ),
          ),
      ],
    );
  }
}
