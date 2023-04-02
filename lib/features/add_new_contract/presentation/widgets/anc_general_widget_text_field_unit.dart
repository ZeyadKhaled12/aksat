import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../start/presentation/widgets/auth_widgets/auth_general_widget_text_field.dart';

class ANCGeneralWidgetTextFieldUnit extends StatelessWidget {
  const ANCGeneralWidgetTextFieldUnit(
      {Key? key,
      required this.hintText,
      required this.iconData,
      this.isPassword = false,
      this.isForNumbersOnly = false,
      this.isPassNavigate = false,
      this.controller,
      this.enabled = true,
      this.onTap,
      this.iconLeft,
      required this.unit, this.onChanged})
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
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    unit,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontsAssets.secondaryArabicFont),
                  ),
                ),
              ),
            ),
            flex: 1),
        Flexible(
          child: AuthGeneralWidgetTextField(
            controller: controller,
            hintText: hintText,
            iconData: iconData,
            onChanged: onChanged,
            isForNumbersOnly: isForNumbersOnly,
            onTap: onTap,
            iconLeft: iconLeft,
            enabled: enabled,
            isPassNavigate: isPassNavigate,
            isPassword: isPassword,
          ),
          flex: 6,
        ),
      ],
    );
  }
}
