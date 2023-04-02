import 'package:aksat/core/utils/enums.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/base_use_case.dart';
import '../entities/contract.dart';
import '../entities/extra.dart';
import '../repository/base_anc_repo.dart';

class UpdateAncInfoUc
    extends BaseUseCaseInside<Contract, UpdateAncInfoParameters> {
  final BaseAncRepo baseAuthRepo;

  UpdateAncInfoUc(this.baseAuthRepo);

  @override
  Contract change(UpdateAncInfoParameters parameters) {
    return baseAuthRepo.updateAncInfo(parameters);
  }
}

class UpdateAncInfoParameters extends Equatable {
  final String? text;
  final double? amount;
  final DateTime? dateTime;
  final List<Extra>? extras;
  final Contract contract;
  final AncInfoKeys ancInfoKeys;

  const UpdateAncInfoParameters({required this.ancInfoKeys,
    this.text,
    this.dateTime,
    this.extras,
    this.amount,
    required this.contract});

  @override
  List<Object?> get props =>
      [text, amount, dateTime, extras, contract, ancInfoKeys];
}
