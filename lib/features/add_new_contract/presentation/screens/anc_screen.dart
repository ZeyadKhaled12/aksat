import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/general_widgets/general_widget_snack_bar.dart';
import '../../../../core/utils/general_widgets/general_widget_title_body.dart';
import '../../../start/domain/entities/company.dart';
import '../../../start/presentation/widgets/auth_widgets/auth_ver_code_widgets/auth_widget_ver_code_alert_dialog.dart';
import '../controller/anc_bloc.dart';
import '../widgets/anc_body.dart';

class ANCScreen extends StatelessWidget {
  const ANCScreen({Key? key, required this.company}) : super(key: key);
  final Company company;

  @override
  Widget build(BuildContext context) {
    return GeneralWidgetTitleBody(
        title: 'تسجيل عقد جديد',
        body: BlocProvider(
          create: (context) => sl<AncBloc>(),
          child: BlocConsumer<AncBloc, AncState>(
            listener: (context, state) {
              if (state.isNewContractAdded) {
                showDialog(
                    context: context,
                    builder: (context) => AuthWidgetVerCodeAlertDialog(
                          fun: () {
                            Navigator.pop(context);
                          },
                          title: 'لقد تم اضافة عقد جديد',
                          milliseconds: 250,
                        ));
              }
              if (state.state == RequestState.error) {
                generalWidgetSnackBar(context, state.errorMessage);
              }
            },
            listenWhen: (previous, current) => previous.state != current.state,
            buildWhen: (previous, current) => previous.state != current.state,
            builder: (context, state) {
              if (state.state == RequestState.loading) {
                return ANCBody(
                    token: company.token,
                    contract: state.contract,
                    isLoading: true);
              }
              if (state.state == RequestState.loaded) {
                return ANCBody(token: company.token, contract: state.contract);
              }
              return ANCBody(token: company.token, contract: state.contract);
            },
          ),
        ));
  }
}
