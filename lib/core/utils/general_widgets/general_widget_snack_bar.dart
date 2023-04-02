import 'package:flutter/material.dart';

import '../assets_manager.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> generalWidgetSnackBar(
        BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(

          content: Text(
            message,
            textAlign: TextAlign.end,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: FontsAssets.secondaryArabicFont),
          ),
          backgroundColor: Colors.black.withOpacity(0.8)),
    );
