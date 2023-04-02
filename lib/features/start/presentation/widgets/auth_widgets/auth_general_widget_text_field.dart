import 'package:aksat/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../screens/auth_screens/forgot_password_screen.dart';

class AuthGeneralWidgetTextField extends StatelessWidget {
  const AuthGeneralWidgetTextField(
      {Key? key,
      required this.hintText,
      required this.iconData,
      this.isPassword = false,
      this.isForNumbersOnly = false,
      this.isPassNavigate = false,
      this.controller,
      this.onChanged,
      this.enabled = true,
      this.onTap,
      this.iconLeft})
      : super(key: key);
  final String hintText;
  final IconData iconData;
  final bool isPassword;
  final bool isForNumbersOnly;
  final bool isPassNavigate;
  final bool enabled;
  final Function()? onTap;
  final Function(String value)? onChanged;
  final TextEditingController? controller;
  final Icon? iconLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: InkWell(
        onTap: onTap,
        child: TextField(
          controller: controller,
          enabled: enabled,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            suffixIcon:
                Icon(iconData, size: 25, color: const Color(0XFF808284)),
            hintStyle: const TextStyle(
                color: Color(0XFF808284),
                fontFamily: FontsAssets.primaryArabicFont,
                fontSize: 21),
            prefixIcon: isPassNavigate
                ? TextButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ));
                    },
                    child: const Text('نسيت؟',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: FontsAssets.primaryArabicFont)),
                  )
                : iconLeft,
          ),
          cursorColor: Colors.black,
          inputFormatters: isForNumbersOnly
              ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
              : null,
          keyboardType: isForNumbersOnly ? TextInputType.number : null,
          style: const TextStyle(
              color: Colors.black,
              fontFamily: FontsAssets.primaryArabicFont,
              fontSize: 21),
          textAlign: TextAlign.right,
          obscureText: isPassword,
        ),
      ),
    );
  }
}
