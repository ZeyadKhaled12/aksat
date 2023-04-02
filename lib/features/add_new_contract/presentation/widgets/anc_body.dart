import 'package:aksat/features/add_new_contract/domain/usecases/add_new_contract_uc.dart';
import 'package:aksat/features/add_new_contract/presentation/controller/anc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../start/presentation/widgets/auth_widgets/auth_general_widget_button.dart';
import '../../domain/entities/contract.dart';
import 'anc_bodies_widgets/anc_widget_banking_body.dart';
import 'anc_bodies_widgets/anc_widget_data_body.dart';
import 'anc_bodies_widgets/anc_widget_dates_body.dart';
import 'anc_bodies_widgets/anc_extra_payments_widgets/anc_widget_extra_payments_body.dart';
import 'anc_bodies_widgets/anc_widget_result_body.dart';

class ANCBody extends StatelessWidget {
  const ANCBody(
      {Key? key,
      required this.contract,
      required this.token,
      this.isLoading = false})
      : super(key: key);
  final Contract contract;
  final String token;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ANCWidgetDataBody(contract: contract),
                ANCWidgetBankingBody(contract: contract),
                ANCWidgetDatesBody(contract: contract),
                ANCWidgetExtraPaymentsBody(contract: contract),
                ANCWidgetResultBody(contract: contract),
                AuthGeneralWidgetButton(
                    title: 'سجل',
                    onPressed: () {
                      context.read<AncBloc>().add(AddNewContractEvent(
                          addNewContractParameters: AddNewContractParameters(
                              contract: contract, token: token)));
                    }),
                const Padding(padding: EdgeInsets.only(bottom: 28)),
              ],
            ),
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
