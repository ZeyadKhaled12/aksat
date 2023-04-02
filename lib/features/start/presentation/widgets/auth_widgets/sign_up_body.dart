import 'package:aksat/features/start/domain/usecases/sign_up_uc.dart';
import 'package:aksat/features/start/presentation/controller/start_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/assets_manager.dart';
import '../../screens/auth_screens/login_screen.dart';
import 'auth_general_widget_body.dart';
import 'auth_general_widget_navigate_button.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({Key? key,
    this.isLoading = false}) : super(key: key);
  final bool isLoading;

  @override
  Widget build(BuildContext context) {

    final List<TextEditingController> controllers =
    List.generate(5, (index) => TextEditingController());

    return AuthGeneralWidgetBody(
        titleButton: 'انشاء حساب',
        controllers: controllers,
        isLoading: isLoading,
        primaryImage: ImageAssets.signUpImage,
        onPressedButton: () {
          context.read<StartBloc>().add(SignUpEvent(
            signUpParameters: SignUpParameters(
              email: controllers[0].text,
              password: controllers[1].text,
              confirmPassword: controllers[2].text,
              compName: controllers[3].text,
              phoneNumber: controllers[4].text
            )));
        },
        titleBody: 'انشاء حساب',
        body: Column(
          children: [
            AuthGeneralWidgetNavigateButton(
              sentence: 'لديك حساب بالفعل؟',
              titleButton: 'تسجيل الدخول',
              onPressed: () async {
                await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
          ],
        ),
        heightOfContainerImage:
        MediaQuery.of(context).size.height * 1 / 2.9,
        numbersIndex: const [4],
        hintTextFieldsList: const [
          'البريد الالكتروني',
          'كلمة المرور',
          'اعادة كلمة المرور',
          'اسم الشركة',
          'رقم الهاتف'
        ],
        iconDataTextFieldsList: const [
          Icons.alternate_email,
          Icons.lock_outline,
          Icons.lock_outline,
          Icons.home_outlined,
          Icons.phone_android_outlined
        ],
        secureIndex: const [
          1, 2
        ]);
  }
}
