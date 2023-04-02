import 'package:flutter/material.dart';

import '../../../../../../core/utils/assets_manager.dart';

class ACSDetailWidgetConvertToPdf extends StatelessWidget {
  const ACSDetailWidgetConvertToPdf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text('pdf', style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),),
        const Text(' تحويل كشف الحساب الي ملف', style: TextStyle(
            color: Colors.black,
            fontSize: 14.5,
            fontWeight: FontWeight.bold
        ),),
        const Padding(padding: EdgeInsets.only(right: 10)),
        SizedBox(
          height: 60,
          child: ElevatedButton(onPressed: (){},
              child: const Image(image: AssetImage(
                  ImageAssets.pdfIcon)), style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 6,
                  padding: const EdgeInsets.all(6.5),
                  shape: const CircleBorder()
              )),
        ),
      ],
    );
  }
}
