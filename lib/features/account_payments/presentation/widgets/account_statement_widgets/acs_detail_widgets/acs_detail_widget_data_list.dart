import 'package:aksat/features/add_new_contract/domain/entities/contract.dart';
import 'package:flutter/material.dart';

import 'acs_detail_widget_data.dart';

class ACSDetailWidgetDataList extends StatelessWidget {
  const ACSDetailWidgetDataList({Key? key, required this.contract}) : super(key: key);
  final Contract contract;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ACSDetailWidgetData(titles: const [
          'اسم العميل',
          'رقم الهاتف',
          'نوع المنتج'
        ], values: [
          contract.customerName,
          contract.phoneNumber,
          contract.productType
        ], title: 'البيانات'),
        ACSDetailWidgetData(titles: const [
          'اجمالي المبلغ (الجنيه)',
          'المدفوع (الجنيه)',
          'قيمة القسط (الجنيه)'
        ], values: [
          '${contract.totalPrice}',
          '${contract.paidUpPrice}',
          '${contract.valueOfKst}'
        ], title: 'البند المالي لحظة تسجيل العقد'),
      ],
    );
  }
}
