import 'package:flutter/material.dart';

import '../../../../../core/utils/assets_manager.dart';

class AuthGeneralWidgetButton extends StatelessWidget {
  const AuthGeneralWidgetButton({Key? key, required this.title,
    required this.onPressed}) : super(key: key);
  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(2),
      child: TextButton(
        onPressed: onPressed,
        child: Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: FontsAssets.primaryArabicFont,
                fontSize: 21)),
      ),
    );
  }
}
