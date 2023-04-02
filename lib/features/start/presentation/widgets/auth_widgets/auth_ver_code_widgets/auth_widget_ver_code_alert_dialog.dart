
import 'package:flutter/material.dart';

import '../../../../../../core/utils/assets_manager.dart';

class AuthWidgetVerCodeAlertDialog extends StatelessWidget {
  const AuthWidgetVerCodeAlertDialog({Key? key,
    this.title = 'لقد تم تفعيل حسابك', this.milliseconds = 2500, this.fun
  })
      : super(key: key);
  final String title;
  final double milliseconds;
  final Function()? fun;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 2500), () async {
      Navigator.pop(context);
      fun!();
    });
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: Text(title,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 19,
              fontWeight: FontWeight.bold,
              fontFamily: FontsAssets.primaryArabicFont),
          textAlign: TextAlign.center),
      actionsPadding: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: const [
        CircleAvatar(
          radius: 43,
          backgroundColor: Colors.green,
          child: CircleAvatar(
            radius: 40,
            child: Icon(
              Icons.check,
              size: 39,
              color: Colors.green,
            ),
            backgroundColor: Colors.white,
          ),
        )
      ],
    );
  }
}
