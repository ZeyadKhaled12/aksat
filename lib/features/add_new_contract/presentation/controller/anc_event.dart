part of 'anc_bloc.dart';

abstract class AncEvent extends Equatable {
  const AncEvent();

  @override
  List<Object> get props => [];
}

class UpdateAncInfoEvent extends AncEvent {
  final UpdateAncInfoParameters updateAncInfoParameters;
  const UpdateAncInfoEvent({required this.updateAncInfoParameters});
  @override
  List<Object> get props => [updateAncInfoParameters];
}

class AddNewContractEvent extends AncEvent {
  final AddNewContractParameters addNewContractParameters;
  const AddNewContractEvent({required this.addNewContractParameters});
  @override
  List<Object> get props => [addNewContractParameters];
}
