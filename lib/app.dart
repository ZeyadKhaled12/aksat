
import 'package:aksat/config/app_theme.dart';
import 'package:aksat/features/start/presentation/screens/init_screen.dart';
import 'package:flutter/material.dart';


class Aksat extends StatelessWidget {
  const Aksat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const InitScreen()
    );
  }
}
