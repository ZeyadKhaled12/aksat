import 'package:aksat/features/start/domain/entities/company.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'profile_screen.dart';

class WindowScreen extends StatefulWidget {
  const WindowScreen({Key? key, required this.company}) : super(key: key);
  final Company company;

  @override
  State<WindowScreen> createState() => _WindowScreenState();
}

class _WindowScreenState extends State<WindowScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: index == 0
                  ? HomeScreen(company: widget.company)
                  : const ProfileScreen()),
          Container(
            width: double.infinity,
            height: 60,
            color: Colors.white,
            child: Row(
              children: [
                bottomIcon(
                    iconDataChosen: Icon(
                      Icons.home,
                      color: Theme.of(context).primaryColor,
                      size: 40,
                    ),
                    iconDataNotChosen: const Icon(
                      Icons.home_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                    isChosen: index == 0,
                    function: () {
                      setState(() {
                        index = 0;
                      });
                    }),
                bottomIcon(
                    iconDataChosen: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                      size: 40,
                    ),
                    iconDataNotChosen: const Icon(
                      Icons.person_outline,
                      color: Colors.black,
                      size: 30,
                    ),
                    isChosen: index == 1,
                    function: () {
                      setState(() {
                        index = 1;
                      });
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget bottomIcon(
    {required Icon iconDataChosen,
    required Icon iconDataNotChosen,
    required bool isChosen,
    required Function() function}) {
  return Flexible(
    child: Center(
      child: IconButton(
          onPressed: function,
          icon: isChosen ? iconDataChosen : iconDataNotChosen),
    ),
  );
}
