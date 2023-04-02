import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../../core/utils/general_widgets/general_widget_snack_bar.dart';
import '../../controller/start_bloc.dart';
import '../../widgets/auth_widgets/auth_ver_code_widgets/auth_ver_code_body.dart';
import '../../widgets/auth_widgets/auth_ver_code_widgets/auth_widget_ver_code_alert_dialog.dart';
import '../../widgets/auth_widgets/login_body.dart';
import '../window_screens/window_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isGetInVerificationCode = false;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocProvider(
          create: (context) => sl<StartBloc>(),
          child: BlocConsumer<StartBloc, StartState>(
            listener: (context, state) {
              if (isGetInVerificationCode &&
                  state.company.token.isNotEmpty &&
                  state.company.isVerification) {
                showDialog(
                    context: context,
                    builder: (context) => AuthWidgetVerCodeAlertDialog(
                          fun: () async {
                            await Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WindowScreen(company: state.company),
                                ));
                          },
                        ));
              }
              if (state.company.token.isNotEmpty &&
                  state.company.isVerification) {
                Future.delayed(const Duration(milliseconds: 2000), () async {
                  await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WindowScreen(
                          company: state.company,
                        ),
                      ));
                });
              }

              if (state.state == RequestState.error) {
                generalWidgetSnackBar(context, state.errorMessage);
              }
            },
            listenWhen: (previous, current) => previous.state != current.state,
            buildWhen: (previous, current) => previous.state != current.state,
            builder: (context, state) {
              if (state.company.token.isNotEmpty &&
                  !state.company.isVerification) {
                isGetInVerificationCode = true;
                return AuthVerCodeBody(company: state.company);
              }
              if (state.state == RequestState.loading) {
                return const LoginBody(isLoading: true);
              }
              if (state.state == RequestState.loaded) {
                return const LoginBody();
              }
              return const LoginBody();
            },
          ),
        ));
  }
}
