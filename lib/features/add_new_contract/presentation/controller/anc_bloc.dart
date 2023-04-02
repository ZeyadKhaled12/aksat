import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/utils/enums.dart';
import '../../domain/entities/contract.dart';
import '../../domain/usecases/add_new_contract_uc.dart';
import '../../domain/usecases/update_anc_info_uc.dart';

part 'anc_event.dart';

part 'anc_state.dart';

class AncBloc extends Bloc<AncEvent, AncState> {
  final UpdateAncInfoUc updateAncInfoUc;
  final AddNewContractUc addNewContractUc;

  AncBloc(this.updateAncInfoUc, this.addNewContractUc)
      : super(const AncState()) {
    on<UpdateAncInfoEvent>(_updateAncInfo);
    on<AddNewContractEvent>(_addNewContract);
  }

  FutureOr<void> _updateAncInfo(
      UpdateAncInfoEvent event, Emitter<AncState> emit) {
    emit(state.copyWith(state: RequestState.loading));
    final result = updateAncInfoUc.change(event.updateAncInfoParameters);
    emit(state.copyWith(contract: result, state: RequestState.loaded));
  }

  FutureOr<void> _addNewContract(
      AddNewContractEvent event, Emitter<AncState> emit) async {
    emit(state.copyWith(state: RequestState.loading));
    final result = await addNewContractUc.call(event.addNewContractParameters);
    result.fold(
        (l) => emit(
            state.copyWith(state: RequestState.error, errorMessage: l.message)),
        (r) => emit(state.copyWith(state: RequestState.loaded, isNewContractAdded: true)));
  }
}
