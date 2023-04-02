import 'package:aksat/features/account_payments/presentation/screens/payments_aksat%20_screen/pk_window_screen.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../account_payments/presentation/screens/account_statement_screens/acs_window_screen.dart';
import '../../../../add_new_contract/presentation/screens/anc_screen.dart';
import '../../../domain/entities/company.dart';
import '../../widgets/home_widgets/home_widget_card.dart';

const List<String> texts = [
  'كشف حساب',
  'تسجيل\nعقود جديدة',
  'الاقساط\nالمستحقة',
  'تسديد الاقساط'
];

const List<String> images = [
  ImageAssets.homeCardOne,
  ImageAssets.homeCardTwo,
  ImageAssets.homeCardThree,
  ImageAssets.homeCardFour
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.company}) : super(key: key);
  final Company company;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
            child: AppBar(backgroundColor: Colors.black),
            preferredSize: const Size.fromHeight(0)),
        body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 32)),
                const Text('الصفحة الرئيسية',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: FontsAssets.primaryArabicFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 29)),
                // const Padding(padding: EdgeInsets.only(bottom: 25)),
                // const HomeWidgetSearch(),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      company.companyName,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontFamily: FontsAssets.primaryArabicFont,
                          fontSize: 20),
                    ),
                    Text(
                      ' اهلا بك شركة',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontFamily: FontsAssets.primaryArabicFont,
                          fontSize: 20),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                Flexible(
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    children: List.generate(
                        4,
                        (index) => HomeWidgetCard(
                            imageUrl: images[index],
                            onTap: () async {
                              await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                if (index == 1) {
                                  return ANCScreen(
                                    company: company,
                                  );
                                }else if(index == 0){
                                  return ACSWindowScreen(
                                    company: company,
                                  );
                                }else if(index == 3){
                                  return PKWindowScreen(
                                    company: company,
                                  );
                                }
                                return const Text('');
                              }));
                            },
                            text: texts[index])),
                  ),
                ),
              ],
            )));
  }
}
