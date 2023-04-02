import 'package:aksat/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

class PKBillWidgetBtns extends StatelessWidget {
  const PKBillWidgetBtns({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          button('تخطي', () {
            Navigator.pop(context);
          }, context),
          const Padding(padding: EdgeInsets.only(right: 28)),
          button('تحميل الفاتورة', () => null, context),

        ],
      ),
    );
  }
}

Widget button(String text, Function() fun, BuildContext context){
  return  Expanded(
    child: ElevatedButton(onPressed: fun, child:
    Text(text, style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
        fontFamily: FontsAssets.primaryArabicFont
    ),),
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          backgroundColor: Theme.of(context).primaryColor
      ),
    ),
  );
}
