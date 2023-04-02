import 'package:flutter/material.dart';

import '../../../../../core/utils/assets_manager.dart';
import '../../widgets/auth_widgets/auth_general_widget_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<TextEditingController> controllers =
    List.generate(1, (index) => TextEditingController());

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: AuthGeneralWidgetBody(
          titleButton: 'ارسال',
          controllers: controllers,
          primaryImage: ImageAssets.lockImage,
          onPressedButton: () {},
          titleBody: 'هل نسيت\nكلمة المرور؟',
          body: Column(
            children: const [
              Padding(padding: EdgeInsets.only(bottom: 60)),
            ],
          ),
          heightOfContainerImage: MediaQuery.of(context).size.height * 1 / 2,
          hintTextFieldsList: const [
            'البريد الالكتروني',
          ],
          iconDataTextFieldsList: const [
            Icons.alternate_email,
          ],
        ));
  }
}
