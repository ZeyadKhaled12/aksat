import 'package:aksat/core/utils/assets_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'auth_screens/login_screen.dart';

const int primeSeconds = 1;

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {


  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    Future.delayed(const Duration(seconds: primeSeconds + 2), () async {
      //Todo delete;
      await FirebaseAuth.instance.signOut();
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
          child: opacityWidget(
              primeSeconds,
              Image(
                  image: const AssetImage(ImageAssets.logoImage),
                  width: MediaQuery.of(context).size.width * 1 / 2.6))),
    );
  }
}

Widget opacityWidget(int seconds, Widget widgetOpacity) {
  return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(seconds: seconds),
      builder: (ctx, value, widget) {
        return Opacity(opacity: value, child: widgetOpacity);
      });
}
