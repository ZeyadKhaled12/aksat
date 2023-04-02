import 'package:aksat/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/utils/assets_manager.dart';
import '../../../../domain/entities/contract.dart';
import '../../../../domain/entities/extra.dart';
import '../../../../domain/usecases/update_anc_info_uc.dart';
import '../../../controller/anc_bloc.dart';

class ANCWidgetExtraPaymentsData extends StatelessWidget {
  const ANCWidgetExtraPaymentsData({Key? key, required this.contract})
      : super(key: key);
  final Contract contract;

  @override
  Widget build(BuildContext context) {
    return contract.extras.isEmpty
        ? const Text(
            'دفعات اضافية',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontFamily: FontsAssets.primaryArabicFont),
          )
        : Expanded(
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                itemBuilder: (context, index) => container(
                    contract.extras[index].price,
                    DateFormat.yMd().format(contract.extras[index].date),
                    contract,
                    index,
                    context),
                itemCount: contract.extras.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          );
  }
}

Widget container(double price, String date, Contract ancInfo, int index,
    BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right: 10),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey, width: 1.5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Text(
                      'جنيه',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: FontsAssets.secondaryArabicFont),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 5)),
                    Text(
                      '$price',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                Text(
                  date,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              final List<Extra> extras = List.from(ancInfo.extras);
              extras.removeAt(index);
              context.read<AncBloc>().add(UpdateAncInfoEvent(
                  updateAncInfoParameters: UpdateAncInfoParameters(
                      contract: ancInfo,
                      ancInfoKeys: AncInfoKeys.extra,
                      extras: extras)));
            },
            icon: const CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(Icons.delete, color: Colors.white),
            ))
      ],
    ),
  );
}
