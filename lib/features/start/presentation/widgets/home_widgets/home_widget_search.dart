
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/assets_manager.dart';
import '../../../../account_payments/domain/usecases/search_uc.dart';
import '../../../../account_payments/presentation/controller/account_payments_bloc.dart';

class HomeWidgetSearch extends StatelessWidget {
  const HomeWidgetSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15)),
      child: TextField(
        style: const TextStyle(
            color: Colors.black,
            fontFamily: FontsAssets.primaryArabicFont,
            fontSize: 21),
        textAlign: TextAlign.right,
        onChanged: (value) {
          context.read<AccountStatementBloc>().add(
            AcsSearchEvent(acsSearchParameters: SearchParameters(
              text: value
            ))
          );
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: const Image(image: AssetImage(
                ImageAssets.iconImage
            ), width: 20),
            hintText: 'البحث عن العملاء ,نوع المنتج',
            hintStyle: TextStyle(
                color: Theme.of(context).primaryColor.withOpacity(0.8),
                fontFamily: FontsAssets.primaryArabicFont,
                fontSize: 18)),
      ),
    );
  }
}
