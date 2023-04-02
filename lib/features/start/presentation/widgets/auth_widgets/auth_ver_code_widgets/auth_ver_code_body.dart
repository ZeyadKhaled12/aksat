
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/assets_manager.dart';
import '../../../../domain/entities/company.dart';
import '../../../../domain/usecases/verified_email_uc.dart';
import '../../../controller/start_bloc.dart';
import '../auth_general_widget_body.dart';

class AuthVerCodeBody extends StatelessWidget {
  const AuthVerCodeBody({Key? key, required this.company}) : super(key: key);
  final Company company;

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> controllers = List.generate(1,
            (index) => TextEditingController());

    return AuthGeneralWidgetBody(titleButton: 'تفعيل الحساب',
        onPressedButton: () async{
          context.read<StartBloc>().add(VerifiedEmailEvent(
            verifiedEmailParameters: VerifiedEmailParameters(
              code: controllers[0].text,
              company: company
            )
          ));
        },
        titleBody: 'رمز التحقق',
        hintTextFieldsList: const [
          'رمز التحقق',
        ],
        iconDataTextFieldsList: const [
          Icons.verified_outlined,
        ],
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
              'أدخل رمز التحقق الذي أرسلناه لك عبر بريدك الإلكتروني',
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.black.withOpacity(0.5),
                  fontSize: 16,
                  fontFamily: FontsAssets.secondaryArabicFont)),
        ),
        heightOfContainerImage: MediaQuery
            .of(context)
            .size
            .height * 1 / 2.9,
        primaryImage: ImageAssets.signUpImage,
        controllers: controllers);
  }
}
