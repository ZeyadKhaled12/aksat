import 'package:aksat/core/utils/assets_manager.dart';
import 'package:aksat/core/utils/enums.dart';
import 'package:flutter/material.dart';
import '../../../../add_new_contract/domain/entities/contract.dart';
import '../../../../start/domain/entities/company.dart';
import '../../../domain/entities/ap.dart';
import '../../widgets/payments_aksat_widgets/pk_detail_widgets/pk_detail_bill_widgets/pk_detail_bill_body.dart';
import '../../widgets/payments_aksat_widgets/pk_detail_widgets/pk_detail_widgets/pk_detail_body.dart';

class PKDetailScreen extends StatefulWidget {
  const PKDetailScreen(
      {Key? key,
      required this.ap,
      required this.contract,
      this.requestState,
      this.isNavigate = false,
      required this.company,
      required this.contextOfBloc, required this.searchBillText})
      : super(key: key);
  final Ap ap;
  final Contract contract;
  final RequestState? requestState;
  final bool isNavigate;
  final Company company;
  final BuildContext contextOfBloc;
  final String searchBillText;

  @override
  State<PKDetailScreen> createState() => _PKDetailScreenState();
}

class _PKDetailScreenState extends State<PKDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        bottom: TabBar(
          indicatorColor: Colors.black,
          indicatorWeight: 4,
          indicatorPadding: const EdgeInsets.only(left: 25, right: 25),
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              child: Text('التسديد',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontsAssets.primaryArabicFont)),
            ),
            Tab(
              child: Text('الفواتير',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontsAssets.primaryArabicFont)),
            ),
          ],
        ),
      ),
      body: TabBarView(children: [
        PKDetailBody(
            ap: widget.ap,
            searchBillText: widget.searchBillText,
            contract: widget.contract,
            isNavigate: widget.isNavigate,
            company: widget.company,
            requestState: widget.requestState,
            contextOfBloc: widget.contextOfBloc),
        PKDetailBillBody(
          searchBillText: widget.searchBillText,
          contextOfBloc: widget.contextOfBloc,
          contract: widget.contract,
          company: widget.company,
          ap: widget.ap,
        )
      ], controller: _tabController),
    );
  }
}
