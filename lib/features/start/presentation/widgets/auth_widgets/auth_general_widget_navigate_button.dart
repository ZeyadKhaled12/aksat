import 'package:aksat/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

class AuthGeneralWidgetNavigateButton extends StatelessWidget {
  const AuthGeneralWidgetNavigateButton(
      {Key? key,
      required this.sentence,
      required this.titleButton,
      required this.onPressed})
      : super(key: key);
  final String sentence;
  final String titleButton;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: onPressed,
            child: Text(
              titleButton,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: FontsAssets.primaryArabicFont,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 10)),
          Text(sentence,
              style: const TextStyle(
                color: Color(0XFF808284),
                fontSize: 11,
                fontFamily: FontsAssets.primaryArabicFont,
              )),
        ],
      ),
    );
  }
}
