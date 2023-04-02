import 'package:aksat/features/start/domain/entities/company.dart';

class CompanyModel extends Company {
  const CompanyModel(
      {required String companyName,
      required String token,
      required String phoneNumber,
      required String email,
      String? verificationCode,
      required bool isVerification})
      : super(
            companyName: companyName,
            token: token,
            verificationCode: verificationCode,
            isVerification: isVerification,
            phoneNumber: phoneNumber,
            email: email);

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
      token: json['token'],
      companyName: json['comp_name'],
      email: json['email'],
      verificationCode: json['ver_code'],
      isVerification: json['is_ver'],
      phoneNumber: json['phone_number']);

  Map<String, dynamic> toJsonSingUp() => {
        'comp_name': companyName,
        'token': token,
        'email': email,
        'ver_code': verificationCode,
        'is_ver': isVerification,
        'phone_number': phoneNumber,
      };

  Map<String, dynamic> toJsonLogin() => {'email': email, 'password': password};
}
