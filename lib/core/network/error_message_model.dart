import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final String statusMessage;
  final bool success;

  const ErrorMessageModel({
    required this.statusMessage,
    required this.success
  });

  factory ErrorMessageModel.fromJson(e) =>
      ErrorMessageModel(
          statusMessage: e.message,
          success: e.message.isEmpty ? true : false);

  @override
  List<Object> get props => [statusMessage, success];

}