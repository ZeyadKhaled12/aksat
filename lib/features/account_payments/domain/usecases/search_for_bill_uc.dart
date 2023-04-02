import 'package:equatable/equatable.dart';

import '../../../../core/usecase/base_use_case.dart';
import '../repository/base_ap_repo.dart';

class SearchForBillUc
    extends BaseUseCaseInside<String, SearchForBillParameters> {
  final BaseApRepo baseAcsRepo;

  SearchForBillUc(this.baseAcsRepo);

  @override
  String change(SearchForBillParameters parameters) {
    return baseAcsRepo.searchForBill(parameters);
  }

}

class SearchForBillParameters extends Equatable {
  final String text;

  const SearchForBillParameters({required this.text});

  @override
  List<Object> get props => [text];
}
