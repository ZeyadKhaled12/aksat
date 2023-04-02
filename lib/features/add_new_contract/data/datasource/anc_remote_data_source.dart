import 'package:aksat/core/utils/enums.dart';
import 'package:aksat/core/utils/general_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/error_message_model.dart';
import '../../../account_payments/data/models/ap_model.dart';
import '../../../account_payments/data/models/ap_table_model.dart';
import '../../../account_payments/data/models/ap_table_row_model.dart';
import '../../domain/entities/contract.dart';
import '../../domain/usecases/add_new_contract_uc.dart';
import '../models/contract_model.dart';
import 'dart:math' as math;

abstract class BaseAncRemoteDataSource {
  Future<ContractModel> addNewContract(
      AddNewContractParameters addNewContractParameters);
}

class AncRemoteDataSource extends BaseAncRemoteDataSource {
  @override
  Future<ContractModel> addNewContract(
      AddNewContractParameters addNewContractParameters) async {

    if (addNewContractParameters.contract.customerName.isEmpty) {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusMessage: 'اسم العميل مطلوب', success: false));
    }
    if (addNewContractParameters.contract.phoneNumber.isEmpty) {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusMessage: 'رقم هاتف العميل مطلوب', success: false));
    }
    if (addNewContractParameters.contract.customerName.isEmpty) {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusMessage: 'نوع المنتج مطلوب', success: false));
    }

    if (addNewContractParameters.contract.totalPrice <= 0) {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusMessage: 'اجمالي المبلغ مطلوب', success: false));
    }
    if (addNewContractParameters.contract.valueOfKst <= 0) {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusMessage: 'قيمة القسط مطلوبة', success: false));
    }

    if (addNewContractParameters.contract.kstSystem <= 0) {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusMessage: 'نظام القسط مطلوب', success: false));
    }
    if (addNewContractParameters.contract.startDate == null) {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusMessage: 'تاريخ بداية الاقساط مطلوب', success: false));
    }
    ContractModel contractModel = ContractModel(
        customerName: addNewContractParameters.contract.customerName,
        phoneNumber: addNewContractParameters.contract.phoneNumber,
        extras: addNewContractParameters.contract.extras,
        productType: addNewContractParameters.contract.productType,
        totalPrice: addNewContractParameters.contract.totalPrice,
        paidUpPrice: addNewContractParameters.contract.paidUpPrice,
        valueOfKst: addNewContractParameters.contract.valueOfKst,
        kstSystem: addNewContractParameters.contract.kstSystem,
        startDate: addNewContractParameters.contract.startDate!);
    DocumentReference docRef = await FirebaseFirestore.instance
        .collection('contracts')
        .doc(addNewContractParameters.token)
        .collection('contracts')
        .add(contractModel.toJson())
        .catchError((e) {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusMessage: 'ظهرت مشكلة في السيرفر', success: false));
    });
    await addNewAcs(
        contract: addNewContractParameters.contract,
        companyToken: addNewContractParameters.token,
        docToken: docRef.id);
    return contractModel;
  }

  Future addNewAcs(
      {required String docToken,
      required Contract contract,
      required String companyToken}) async {
    DateTime dateTime = contract.startDate!;
    final List<ApTableRowModel> aksatRows = [];
    final List<ApTableRowModel> paymentsRows = [];

    for (var element in contract.extras) {
      paymentsRows.add(ApTableRowModel(
          aksatStatus: AksatStatus.normal,
          apTableRowBill: ApTableRowBillModel(
            token: getTokenBill(),
          ),
          date: element.date,
          price: element.price,
          isDone: false));
    }
    GeneralFunctions generalFunctions = GeneralFunctions();
    PriceAksatNumberOfKstKstDuration priceAksatNumberOfKstKstDuration =
        generalFunctions.getPriceAksatNumberOfKstKstDuration(
            contract: contract);

    for (int i = 0; i < priceAksatNumberOfKstKstDuration.numberOfKst; i++) {
      aksatRows.add(ApTableRowModel(
          apTableRowBill: ApTableRowBillModel(
            token: getTokenBill(),
          ),
          aksatStatus: AksatStatus.normal,
          date: dateTime,
          price: contract.valueOfKst,
          isDone: false));
      dateTime = DateTime(
          dateTime.year, dateTime.month + contract.kstSystem, dateTime.day);
    }

    final ApTableModel acsTablePayments = ApTableModel(rows: paymentsRows);
    final ApTableModel acsTableAksat = ApTableModel(rows: aksatRows);

    final ApModel acsModel = ApModel(
        apTableAksat: acsTableAksat,
        tokenOfAp: '',
        apTablePayments: acsTablePayments,
        tokenOfContract: docToken);

    await FirebaseFirestore.instance
        .collection('account_statements')
        .doc(companyToken)
        .collection('account_statements')
        .add(acsModel.toJson())
        .catchError((e) {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusMessage: 'ظهرت مشكلة في السيرفر', success: false));
    });
  }

  String getTokenBill() {
    String token =
        '${math.Random().nextInt(9)}${math.Random().nextInt(9)}${math.Random()
        .nextInt(9)}${math.Random().nextInt(9)}${math.Random().nextInt(9)}';
    return token;
  }
}

//add contracts
/*

    List customerName = ['فهمي', 'ابانوب جمال', 'anton', 'estr', 'زياد'];
    List phoneNumber = [
      '0155558858',
      '01008868634',
      '012384937578',
      '05878',
      '01008868634'
    ];
    List productType = [
      'تلفون ايفون',
      'شقه رقم ٢٠ برج مارينا',
      'bag',
      'zink',
      'شقه رقم ٦ برج مارينا الدور السادس'
    ];

    for (int i = 0; i < customerName.length; i++) {

      ContractModel contractModel = ContractModel(
          customerName: customerName[i],
          phoneNumber: phoneNumber[i],
          extras: const [],
          productType: productType[i],
          totalPrice: 1000,
          paidUpPrice: 0,
          valueOfKst: 100,
          kstSystem: 2,
          startDate: DateTime.now());
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('contracts')
          .doc(addNewContractParameters.token)
          .collection('contracts')
          .add(contractModel.toJson())
          .catchError((e) {
        throw const ServerException(
            errorMessageModel: ErrorMessageModel(
                statusMessage: 'ظهرت مشكلة في السيرفر', success: false));
      });
      await addNewAcs(
          contract: contractModel,
          companyToken: addNewContractParameters.token,
          docToken: docRef.id);
    }
    return ContractModel(
        customerName: '',
        phoneNumber: '',
        extras: const [],
        productType: '',
        totalPrice: 0,
        paidUpPrice: 0,
        valueOfKst: 0,
        kstSystem: 0,
        startDate: DateTime.now());
 */
