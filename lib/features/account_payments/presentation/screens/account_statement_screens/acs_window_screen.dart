import 'package:aksat/core/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../../core/utils/general_widgets/general_widget_title_body.dart';
import '../../../../start/domain/entities/company.dart';
import '../../../domain/usecases/get_ap_list_uc.dart';
import '../../controller/account_payments_bloc.dart';
import '../../widgets/ap_window_widgets/ap_window_body.dart';

class ACSWindowScreen extends StatelessWidget {
  const ACSWindowScreen({Key? key, required this.company}) : super(key: key);
  final Company company;

  @override
  Widget build(BuildContext context) {
    return GeneralWidgetTitleBody(
        title: 'كشف الحساب',
        body: BlocProvider(
          create: (context) => sl<AccountStatementBloc>()
            ..add(GetApListEvent(
                getApListParameters:
                    GetApListParameters(companyToken: company.token))),
          child: BlocConsumer<AccountStatementBloc, AccountStatementState>(
            listener: (context, state) {},
            listenWhen: (previous, current) => previous.state != current.state,
            buildWhen: (previous, current) => previous.state != current.state,
            builder: (context, state) {
              switch (state.state) {
                case RequestState.loading:
                  return APWindowBody(
                      listContracts: state.listContracts,
                      company: company,
                      searchBillText: state.searchBillText,
                      filtersAksatStatus: state.filtersAksatStatus,
                      searchText: '',
                      listAp: state.listAp,
                      isLoading: true);
                case RequestState.loaded:
                  return APWindowBody(
                      listContracts: state.listContracts,
                      filtersAksatStatus: state.filtersAksatStatus,
                      company: company,
                      searchBillText: state.searchBillText,
                      searchText: state.searchText,
                      listAp: state.listAp);
                case RequestState.error:
                  return APWindowBody(
                      listContracts: state.listContracts,
                      company: company,
                      searchBillText: state.searchBillText,
                      filtersAksatStatus: state.filtersAksatStatus,
                      searchText: '',
                      listAp: state.listAp,
                      isLoading: true);
              }
            },
          ),
        ));
  }
}
