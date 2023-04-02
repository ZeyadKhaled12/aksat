
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../domain/usecases/login_uc.dart';
import '../../controller/start_bloc.dart';
import '../../screens/auth_screens/sign_up_screen.dart';
import 'auth_general_widget_body.dart';
import 'auth_general_widget_navigate_button.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key, this.isLoading = false}) : super(key: key);
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> controllers =
        List.generate(2, (index) => TextEditingController());

    return AuthGeneralWidgetBody(
        titleButton: 'تسجيل الدخول',
        isLoading: isLoading,
        primaryImage: ImageAssets.loginImage,
        onPressedButton: () async {
          context.read<StartBloc>().add(LoginEvent(
              loginParameters: LoginParameters(
                  email: controllers[0].text, password: controllers[1].text)));
        },
        controllers: controllers,
        passNavigateIndex: const [1],
        titleBody: 'تسجيل الدخول',
        body: Column(
          children: [
            AuthGeneralWidgetNavigateButton(
              sentence: 'ليس لديك حساب؟',
              titleButton: 'انشاء حساب',
              onPressed: () async {
                await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ));
              },
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
          ],
        ),
        heightOfContainerImage: MediaQuery.of(context).size.height * 1 / 2.9,
        hintTextFieldsList: const ['البريد الالكتروني', 'كلمة المرور'],
        iconDataTextFieldsList: const [
          Icons.alternate_email,
          Icons.lock_outline
        ],
        secureIndex: const [1]);
  }
}
