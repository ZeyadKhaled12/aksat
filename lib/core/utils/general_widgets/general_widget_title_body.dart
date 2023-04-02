import 'package:flutter/material.dart';

import '../assets_manager.dart';

class GeneralWidgetTitleBody extends StatelessWidget {
  const GeneralWidgetTitleBody(
      {Key? key, required this.body, required this.title})
      : super(key: key);
  final Widget body;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: FontsAssets.secondaryArabicFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
          ],
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: body,
    );
  }
}
