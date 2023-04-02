import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String companyName;
  final String token;
  final String phoneNumber;
  final String email;
  final String? verificationCode;
  final bool isVerification;
  final String? password;

  const Company(
      {required this.companyName,
      this.password,
      this.verificationCode,
      required this.isVerification,
      required this.token,
      required this.phoneNumber,
      required this.email});

  @override
  List<Object?> get props => [companyName, token, phoneNumber, email, password];
}
