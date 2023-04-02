import 'package:aksat/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/utils/assets_manager.dart';
import '../../../../domain/entities/contract.dart';
import '../../../../domain/entities/extra.dart';
import '../../../../domain/usecases/update_anc_info_uc.dart';
import '../../../controller/anc_bloc.dart';
import 'anc_widget_extra_payments_data.dart';

class ANCWidgetExtraPaymentsBody extends StatefulWidget {
  const ANCWidgetExtraPaymentsBody({Key? key, required this.contract})
      : super(key: key);
  final Contract contract;

  @override
  State<ANCWidgetExtraPaymentsBody> createState() =>
      _ANCWidgetExtraPaymentsBodyState();
}

class _ANCWidgetExtraPaymentsBodyState
    extends State<ANCWidgetExtraPaymentsBody> {
  DateTime? dateTime;
  final TextEditingController price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ANCWidgetExtraPaymentsData(contract: widget.contract),
          const Padding(padding: EdgeInsets.only(left: 25)),
          ElevatedButton(
              onPressed: () async {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  context: context,
                  builder: (ctx) {
                    return StatefulBuilder(
                      builder: (ctx, setState) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              textField(
                                  hintText: 'قيمة الدفعة',
                                  controller: price,
                                  isForNumbersOnly: true),
                              textField(
                                  hintText: 'تاريخ الدفعة',
                                  enabled: false,
                                  controller: TextEditingController(
                                      text: dateTime == null
                                          ? ''
                                          : DateFormat('y/M/d')
                                              .format(dateTime!)),
                                  onTap: () async {
                                    dateTime = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1990, 1),
                                        lastDate: DateTime(2090, 1));
                                    setState(() {});
                                  }),
                              TextButton(
                                  onPressed: () {
                                    if (price.text.isNotEmpty &&
                                        dateTime != null) {
                                      final List<Extra> extras =
                                      List.from(widget.contract.extras);
                                      extras.add(Extra(
                                          price: double.parse(price.text),
                                          date: dateTime!));
                                      context.read<AncBloc>().add(
                                              UpdateAncInfoEvent(
                                                  updateAncInfoParameters:
                                                      UpdateAncInfoParameters(
                                            contract: widget.contract,
                                            ancInfoKeys: AncInfoKeys.extra,
                                            extras: extras,
                                          )));
                                      price.clear();
                                      dateTime = null;
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text(
                                    'اضافة',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily:
                                            FontsAssets.primaryArabicFont),
                                  ))
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              child: const Text('+',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(11),
                  elevation: 10)),
        ],
      ),
    );
  }
}

Widget textField(
    {required String hintText,
    bool isForNumbersOnly = false,
    Function()? onTap,
    required TextEditingController controller,
    bool enabled = true}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
    child: InkWell(
      onTap: onTap,
      child: TextField(
        textAlign: TextAlign.center,
        enabled: enabled,
        controller: controller,
        inputFormatters: isForNumbersOnly
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : null,
        keyboardType: isForNumbersOnly ? TextInputType.number : null,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontFamily: FontsAssets.primaryArabicFont)),
      ),
    ),
  );
}

final Row title = Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: const [
    Text(
      'اضافة دفعة جديدة',
      style: TextStyle(
          color: Colors.black,
          fontFamily: FontsAssets.primaryArabicFont,
          fontSize: 19),
    ),
  ],
);
