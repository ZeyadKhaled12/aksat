import 'package:flutter/material.dart';

import '../../../../../core/utils/assets_manager.dart';
import 'auth_general_widget_button.dart';
import 'auth_general_widget_text_field.dart';

class AuthGeneralWidgetBody extends StatelessWidget {
  const AuthGeneralWidgetBody(
      {Key? key,
      required this.titleButton,
      required this.onPressedButton,
      required this.titleBody,
      required this.hintTextFieldsList,
      required this.iconDataTextFieldsList,
      this.secureIndex = const [],
      this.body,
      required this.heightOfContainerImage,
      required this.primaryImage,
      this.numbersIndex = const [],
      this.passNavigateIndex = const [],
      required this.controllers, this.isLoading = false})
      : super(key: key);
  final String titleButton;
  final Function() onPressedButton;
  final String titleBody;
  final List<String> hintTextFieldsList;
  final List<IconData> iconDataTextFieldsList;
  final List<int> secureIndex;
  final double heightOfContainerImage;
  final Widget? body;
  final String primaryImage;
  final List<int> numbersIndex;
  final List<int> passNavigateIndex;
  final List<TextEditingController> controllers;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100))),
                width: double.infinity,
                height: heightOfContainerImage,
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Image(image: AssetImage(primaryImage))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(titleBody,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontFamily: FontsAssets.primaryArabicFont,
                            fontWeight: FontWeight.bold)),
                    const Padding(padding: EdgeInsets.only(bottom: 20)),
                    Column(
                      children: List.generate(
                        hintTextFieldsList.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 29),
                          child: AuthGeneralWidgetTextField(
                            isPassNavigate: passNavigateIndex.contains(index),
                            hintText: hintTextFieldsList[index],
                            controller: controllers[index],
                            isForNumbersOnly: numbersIndex.contains(index),
                            iconData: iconDataTextFieldsList[index],
                            isPassword: secureIndex.contains(index),
                          ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 40)),
                    AuthGeneralWidgetButton(
                        onPressed: onPressedButton, title: titleButton),
                    if (body != null) body!
                  ],
                ),
              ),
            ],
          ),
        ),
        if(isLoading)
          Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white.withOpacity(0.8),
          child: Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor)),
          ),
        )
      ],
    );
  }
}
