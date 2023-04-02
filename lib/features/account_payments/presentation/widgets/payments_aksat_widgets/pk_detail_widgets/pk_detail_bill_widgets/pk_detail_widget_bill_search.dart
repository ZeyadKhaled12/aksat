import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/utils/assets_manager.dart';
import '../../../../../domain/usecases/search_for_bill_uc.dart';
import '../../../../controller/account_payments_bloc.dart';

class PKDetailWidgetBillSearch extends StatelessWidget {
  const PKDetailWidgetBillSearch({Key? key, required this.contextOfBloc})
      : super(key: key);
  final BuildContext contextOfBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        style: const TextStyle(
            color: Colors.black,
            fontFamily: FontsAssets.primaryArabicFont,
            fontSize: 21),
        textAlign: TextAlign.right,
        onChanged: (value) {
          contextOfBloc.read<AccountStatementBloc>().add(SearchForBillEvent(
              searchForBillParameters: SearchForBillParameters(text: value)));
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: const Image(
                image: AssetImage(ImageAssets.iconImage), width: 20),
            hintText: 'البحث عن رقم ايصال الفاتورة',
            hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontFamily: FontsAssets.primaryArabicFont,
                fontSize: 18)),
      ),
    );
  }
}
