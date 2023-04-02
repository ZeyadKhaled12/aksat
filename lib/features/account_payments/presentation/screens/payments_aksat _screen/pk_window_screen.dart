import 'package:aksat/features/start/domain/entities/company.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/services_locator.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../../core/utils/general_widgets/general_widget_title_body.dart';
import '../../../domain/usecases/get_ap_list_uc.dart';
import '../../controller/account_payments_bloc.dart';
import '../../widgets/ap_window_widgets/ap_window_body.dart';

class PKWindowScreen extends StatelessWidget {
  const PKWindowScreen({Key? key, required this.company}) : super(key: key);
  final Company company;

  @override
  Widget build(BuildContext context) {
    return GeneralWidgetTitleBody(
        title: 'تسديد الاقساط',
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
                      filtersAksatStatus: state.filtersAksatStatus,
                      searchText: '',
                      isPk: true,
                      searchBillText: state.searchBillText,
                      company: company,
                      requestState: state.state,
                      listAp: state.listAp,
                      isLoading: true);
                case RequestState.loaded:
                  return APWindowBody(
                      listContracts: state.listContracts,
                      filtersAksatStatus: state.filtersAksatStatus,
                      isPk: true,
                      company: company,
                      searchBillText: state.searchBillText,
                      requestState: state.state,
                      searchText: state.searchText,
                      listAp: state.listAp);
                case RequestState.error:
                  return APWindowBody(
                      listContracts: state.listContracts,
                      filtersAksatStatus: state.filtersAksatStatus,
                      searchText: '',
                      isPk: true,
                      searchBillText: state.searchBillText,
                      company: company,
                      requestState: state.state,
                      listAp: state.listAp,
                      isLoading: true);
              }
            },
          ),
        ));
  }
}
