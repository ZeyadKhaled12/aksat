
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/enums.dart';
import '../../../domain/entities/contract.dart';
import '../../../domain/usecases/update_anc_info_uc.dart';
import '../../controller/anc_bloc.dart';
import '../anc_general_widget_table.dart';
import '../anc_general_widget_text_field_unit.dart';

class ANCWidgetBankingBody extends StatelessWidget {
  const ANCWidgetBankingBody(
      {Key? key, required this.contract}) : super(key: key);
  final Contract contract;

  @override
  Widget build(BuildContext context) {
    return ANCGeneralWidgetTable(
      body: Column(
        children: [
          ANCGeneralWidgetTextFieldUnit(
            hintText: 'اجمالي المبلغ',
            onChanged: (value) {
              context.read<AncBloc>().add(UpdateAncInfoEvent(
                  updateAncInfoParameters: UpdateAncInfoParameters(
                      contract: contract,
                      amount: value.isEmpty?0:double.parse(value),
                      ancInfoKeys: AncInfoKeys.totalPrice)));
            },
            iconData: Icons.attach_money,
            isForNumbersOnly: true,
            unit: 'جنيه',
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          ANCGeneralWidgetTextFieldUnit(
            hintText: 'المدفوع',
            iconData: Icons.attach_money,
            isForNumbersOnly: true,
            onChanged: (value) {
              context.read<AncBloc>().add(UpdateAncInfoEvent(
                  updateAncInfoParameters: UpdateAncInfoParameters(
                      contract: contract,
                      amount:  value.isEmpty?0:double.parse(value),
                      ancInfoKeys: AncInfoKeys.paidUpPrice)));
            },
            unit: 'جنيه',
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          ANCGeneralWidgetTextFieldUnit(
            hintText: 'قيمة القسط',
            iconData: Icons.attach_money,
            onChanged: (value) {
              context.read<AncBloc>().add(UpdateAncInfoEvent(
                  updateAncInfoParameters: UpdateAncInfoParameters(
                      contract: contract,
                      amount:  value.isEmpty?0:double.parse(value),
                      ancInfoKeys: AncInfoKeys.valueOfKst)));
            },
            isForNumbersOnly: true,
            unit: 'جنيه',
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
        ],
      ),
      title: 'البند المالي',
    );
  }
}
