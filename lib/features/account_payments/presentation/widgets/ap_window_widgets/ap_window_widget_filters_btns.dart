import 'package:aksat/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/assets_manager.dart';
import '../../../domain/usecases/choose_filters_uc.dart';
import '../../controller/account_payments_bloc.dart';

class APWindowWidgetFiltersBtns extends StatefulWidget {
  const APWindowWidgetFiltersBtns({Key? key, required this.isPk}) : super(key: key);
  final bool isPk;

  @override
  State<APWindowWidgetFiltersBtns> createState() =>
      _APWindowWidgetFiltersBtnsState();
}

class _APWindowWidgetFiltersBtnsState
    extends State<APWindowWidgetFiltersBtns> {
  int indexChosen = -1;
  List<String> texts = [
    'الكل',
    'عليه اقساط قادمة',
    'عليه اقساط متأخرة',
    'مسدد جميع الاقساط حتي الان',
  ];

  @override
  void initState() {
    if(widget.isPk){
      texts.removeLast();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ListView(
          scrollDirection: Axis.horizontal,
          reverse: true,
          children: List.generate(
              texts.length,
              (index) => button(
                  text: texts[index],
                  fun: () {
                    context.read<AccountStatementBloc>().add(ChooseFilterEvent(
                        chooseFiltersParameters: ChooseFiltersParameters(
                            aksatStatus: index == 0
                                ? AksatStatus.all
                                : index == 1
                                    ? AksatStatus.close
                                    : index == 2
                                        ? AksatStatus.late
                                        : AksatStatus.done)));
                    setState(() {
                      indexChosen = index;
                    });
                  },
                  isChosen: index == indexChosen,
                  context: context))),
    );
  }
}

Widget button(
    {required String text,
    required Function() fun,
    required bool isChosen,
    required BuildContext context}) {
  return SizedBox(
    height: 40,
    child: Padding(
      padding: const EdgeInsets.only(right: 20),
      child: TextButton(
          onPressed: fun,
          child: Text(text,
              style: TextStyle(
                  color: isChosen ? Colors.white : Colors.black,
                  fontSize: 15,
                  fontFamily: FontsAssets.secondaryArabicFont)),
          style: TextButton.styleFrom(
              backgroundColor: isChosen
                  ? Theme.of(context).primaryColor.withOpacity(0.8)
                  : Colors.white,
              padding: const EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  side:
                      BorderSide(color: Colors.black, width: isChosen ? 0 : 2),
                  borderRadius: BorderRadius.circular(20)))),
    ),
  );
}
