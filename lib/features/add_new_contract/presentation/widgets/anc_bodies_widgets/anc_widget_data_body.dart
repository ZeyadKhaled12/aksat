
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/enums.dart';
import '../../../../start/presentation/widgets/auth_widgets/auth_general_widget_text_field.dart';
import '../../../domain/entities/contract.dart';
import '../../../domain/usecases/update_anc_info_uc.dart';
import '../../controller/anc_bloc.dart';
import '../anc_general_widget_table.dart';

class ANCWidgetDataBody extends StatelessWidget {
  const ANCWidgetDataBody({Key? key, required this.contract}) : super(key: key);
  final Contract contract;

  @override
  Widget build(BuildContext context) {
    return ANCGeneralWidgetTable(
      body: Column(
        children: [
          AuthGeneralWidgetTextField(
              hintText: 'اسم العميل',
              onChanged: (value) {
                context.read<AncBloc>().add(UpdateAncInfoEvent(
                    updateAncInfoParameters: UpdateAncInfoParameters(
                        contract: contract,
                        text: value,
                        ancInfoKeys: AncInfoKeys.customerName)));
              },
              iconData: Icons.person_outline),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          AuthGeneralWidgetTextField(
              hintText: 'رقم هاتف العميل',
              isForNumbersOnly: true,
              onChanged: (value) {
                context.read<AncBloc>().add(UpdateAncInfoEvent(
                    updateAncInfoParameters: UpdateAncInfoParameters(
                        contract: contract,
                        text: value,
                        ancInfoKeys: AncInfoKeys.phoneNumber)));
              },
              iconData: Icons.phone_android),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          AuthGeneralWidgetTextField(
              hintText: 'نوع المنتج',
              onChanged: (value) {
                context.read<AncBloc>().add(UpdateAncInfoEvent(
                    updateAncInfoParameters: UpdateAncInfoParameters(
                        contract: contract,
                        text: value,
                        ancInfoKeys: AncInfoKeys.productType)));
              },
              iconData: Icons.category
              //iconLeft: const Icon(Icons.arrow_drop_down, size: 25, color: Color(0XFF808284)),
              )
        ],
      ),
      title: 'بيانات',
    );
  }
}
