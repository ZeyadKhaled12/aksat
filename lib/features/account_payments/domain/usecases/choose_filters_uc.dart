import 'package:aksat/core/utils/enums.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/base_use_case.dart';
import '../repository/base_ap_repo.dart';

class ChooseFiltersUc
    extends BaseUseCaseInside<AksatStatus, ChooseFiltersParameters> {
  final BaseApRepo baseAcsRepo;

  ChooseFiltersUc(this.baseAcsRepo);

  @override
  AksatStatus change(ChooseFiltersParameters parameters) {
    return baseAcsRepo.chooseFilters(parameters);
  }

}

class ChooseFiltersParameters extends Equatable {
  final AksatStatus aksatStatus;

  const ChooseFiltersParameters({required this.aksatStatus});

  @override
  List<Object> get props => [aksatStatus];
}
