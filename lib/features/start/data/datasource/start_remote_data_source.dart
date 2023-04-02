import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/error_message_model.dart';
import '../../domain/usecases/login_uc.dart';
import '../../domain/usecases/sign_up_uc.dart';
import '../../domain/usecases/verified_email_uc.dart';
import '../models/company_model.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

abstract class BaseStartRemoteDataSource {
  Future<CompanyModel> login(LoginParameters loginParameters);

  Future<CompanyModel> signUp(SignUpParameters signUpParameters);

  Future<CompanyModel> verifiedEmail(
      VerifiedEmailParameters verifiedEmailParameters);
}

class StartRemoteDataSource extends BaseStartRemoteDataSource {
  @override
  Future<CompanyModel> login(LoginParameters loginParameters) async {
    String token = '';
    if (loginParameters.email.isEmpty) {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusMessage: 'البريد الالكتروني مطلوب', success: false));
    }
    if (loginParameters.password.isEmpty) {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusMessage: 'كلمة المرور مطلوبة', success: false));
    }
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: loginParameters.email, password: loginParameters.password)
        .then((value) {
      token = value.user!.uid;
    }).catchError((e) {
      String message = '';
      if (e.message == 'The email address is badly formatted.') {
        message = 'البريد الاكتروني مكتوب بطريقة خاطئة';
      } else {
        message = 'البريد الالكتروني او كلمة المرور خاطئة';
      }
      throw ServerException(
          errorMessageModel:
              ErrorMessageModel(statusMessage: message, success: false));
    });
    CompanyModel userModel = await _getUserDetail(token);
    return userModel;
  }

  Future _sendEmail({
    required String compName,
    required String toEmail,
    required String verificationCode,
  }) async {
    const serviceId = 'service_lpl466d';
    const templateId = 'template_2z3mmj8';
    const userId = 'gWVCe3I6soxTAe0BJ';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_subject': 'Activate your account',
            'to_name': compName,
            'from_name': 'Aksat',
            'to_email': toEmail,
            'message': 'Your verification code is $verificationCode',
            'user_email': 'zeyadkhaled34444@gmail.com'
          }
        }));
  }

  Future<CompanyModel> _getUserDetail(String token) async {
    CompanyModel userModel = await FirebaseFirestore.instance
        .collection('profile_information')
        .doc(token)
        .get()
        .then((value) => CompanyModel.fromJson(value.data()!));
    return userModel;
  }

  String _makeVerCode() {
    math.Random().nextInt(9);
    final String code =
        '${math.Random().nextInt(9)}${math.Random().nextInt(9)}${math.Random().nextInt(9)}${math.Random().nextInt(9)}${math.Random().nextInt(9)}${math.Random().nextInt(9)}';
    return code;
  }

  @override
  Future<CompanyModel> signUp(SignUpParameters signUpParameters) async {
    String token = '';

    if (signUpParameters.email.isEmpty) {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusMessage: 'البريد الالكتروني مطلوب', success: false));
    } else if (signUpParameters.password.isEmpty) {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusMessage: 'كلمة المرور مطلوبة', success: false));
    } else if (signUpParameters.password != signUpParameters.confirmPassword) {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusMessage: 'كلمات المرور غير متطابقة', success: false));
    } else if (signUpParameters.compName.isEmpty) {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusMessage: 'اسم الشركة مطلوب', success: false));
    } else if (signUpParameters.phoneNumber.isEmpty) {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusMessage: 'رقم الهاتف مطلوب', success: false));
    }

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: signUpParameters.email, password: signUpParameters.password)
        .then((value) {
      token = value.user!.uid;
    }).catchError((e) {
      if (e.message == 'The email address is badly formatted.') {
        throw const ServerException(
            errorMessageModel: ErrorMessageModel(
                statusMessage: 'البريد الاكتروني مكتوب بطريقة خاطئة',
                success: false));
      } else if (e.message == 'Password should be at least 6 characters') {
        throw const ServerException(
            errorMessageModel: ErrorMessageModel(
                statusMessage: 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل',
                success: false));
      } else if (e.message ==
          'The email address is already in use by another account.') {
        throw const ServerException(
            errorMessageModel: ErrorMessageModel(
                statusMessage: 'هذا البريد تم استخدامه من قبل',
                success: false));
      }
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(e));
    });

    String verCode = _makeVerCode();

    CompanyModel userModel = CompanyModel(
        companyName: signUpParameters.compName,
        token: token,
        isVerification: false,
        verificationCode: verCode,
        phoneNumber: signUpParameters.phoneNumber,
        email: signUpParameters.email);
    await _sendEmail(
        compName: signUpParameters.compName,
        toEmail: signUpParameters.email,
        verificationCode: verCode);

    await FirebaseFirestore.instance
        .collection('profile_information')
        .doc(token)
        .set(userModel.toJsonSingUp())
        .catchError((e) {
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(e));
    });
    return userModel;
  }

  @override
  Future<CompanyModel> verifiedEmail(
      VerifiedEmailParameters verifiedEmailParameters) async {
    final bool isVerified = verifiedEmailParameters.code ==
        verifiedEmailParameters.company.verificationCode;
    if (isVerified) {
      final CompanyModel companyModel = CompanyModel(
          companyName: verifiedEmailParameters.company.companyName,
          token: verifiedEmailParameters.company.token,
          phoneNumber: verifiedEmailParameters.company.phoneNumber,
          email: verifiedEmailParameters.company.email,
          isVerification: true);
      await FirebaseFirestore.instance
          .collection('profile_information')
          .doc(verifiedEmailParameters.company.token)
          .update(companyModel.toJsonSingUp());
      return companyModel;
    } else {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusMessage: 'كود التحقق غير صحيح', success: false));
    }
  }
}
