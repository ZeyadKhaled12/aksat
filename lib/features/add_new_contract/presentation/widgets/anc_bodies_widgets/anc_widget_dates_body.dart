
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/enums.dart';
import '../../../../start/presentation/widgets/auth_widgets/auth_general_widget_text_field.dart';
import '../../../domain/entities/contract.dart';
import '../../../domain/usecases/update_anc_info_uc.dart';
import '../../controller/anc_bloc.dart';
import '../anc_general_widget_table.dart';
import '../anc_general_widget_text_field_unit.dart';

class ANCWidgetDatesBody extends StatelessWidget {
  const ANCWidgetDatesBody({Key? key, required this.contract}) : super(key: key);
  final Contract contract;

  @override
  Widget build(BuildContext context) {
    return ANCGeneralWidgetTable(
      body: Column(
        children: [
          ANCGeneralWidgetTextFieldUnit(
            hintText: 'نظام القسط',
            onChanged: (value) {
              context.read<AncBloc>().add(UpdateAncInfoEvent(
                  updateAncInfoParameters: UpdateAncInfoParameters(
                      contract: contract,
                      amount: double.parse(value),
                      ancInfoKeys: AncInfoKeys.kstSystem)));
            },
            iconData: Icons.storage,
            isForNumbersOnly: true,
            unit: 'شهور',
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          AuthGeneralWidgetTextField(
            iconData: Icons.date_range,
            hintText: 'تاريخ بداية الاقساط',
            controller: TextEditingController(text: contract.startDate == null?
            '': DateFormat.yMd().format(contract.startDate!)),
            onTap: () async {
              DateTime? date = await showDatePicker(
                  context: context,
                  initialDate:  DateTime.now(),
                  firstDate:DateTime(1990),
                  lastDate: DateTime(2030));
              context.read<AncBloc>().add(UpdateAncInfoEvent(
                  updateAncInfoParameters: UpdateAncInfoParameters(
                      contract: contract,
                      dateTime: date,
                      ancInfoKeys: AncInfoKeys.startDate)));
            },
            enabled: false,
          ),
        ],
      ),
      title: 'المدد الزمنية',
    );
  }
}
