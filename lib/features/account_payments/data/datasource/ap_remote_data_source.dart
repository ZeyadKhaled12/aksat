import 'package:aksat/core/utils/enums.dart';
import 'package:aksat/features/account_payments/data/models/ap_table_row_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/error_message_model.dart';
import '../../../add_new_contract/data/models/contract_model.dart';
import '../../domain/entities/ap.dart';
import '../../domain/usecases/get_ap_list_uc.dart';
import '../../domain/usecases/get_contracts_list_uc.dart';
import '../../domain/usecases/pay_uc.dart';
import '../models/ap_model.dart';

abstract class BaseApRemoteDataSource {
  Future<List<ApModel>> getApList(GetApListParameters getApListParameters);

  Future<List<ContractModel>> getContractsList(
      GetContractsListParameters getContractsListParameters);

  Future<ApModel> pay(PayParameters parameters);
}

class ApRemoteDataSource extends BaseApRemoteDataSource {
  @override
  Future<List<ApModel>> getApList(
      GetApListParameters getApListParameters) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('account_statements')
        .doc(getApListParameters.companyToken)
        .collection('account_statements')
        .get()
        .catchError((e) {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusMessage: 'ظهرت مشكلة في السيرفر', success: false));
    });
    final List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    List<ApModel> acsList = [];
    int index = 0;
    for (var element in allData) {
      acsList.add(ApModel.fromJson(element, querySnapshot.docs[index].id));
      index++;
    }
    return acsList;
  }

  @override
  Future<List<ContractModel>> getContractsList(
      GetContractsListParameters getContractsListParameters) async {
    List<ContractModel> contractsList = [];
    int index = 0;
    for (var element in getContractsListParameters.listContractToken) {
      await FirebaseFirestore.instance
          .collection('contracts')
          .doc(getContractsListParameters.companyToken)
          .collection('contracts')
          .doc(element)
          .get()
          .catchError((e) {
        throw const ServerException(
            errorMessageModel: ErrorMessageModel(
                statusMessage: 'ظهرت مشكلة في السيرفر', success: false));
      }).then((value) {
        contractsList.add(ContractModel.fromJson(value.data()!,
            aksatStatus: getContractsListParameters.listAksatStatus[index]));
      });
      index++;
    }
    return contractsList;
  }

  @override
  Future<ApModel> pay(PayParameters parameters) async {
    ApModel apModel = await FirebaseFirestore.instance
        .collection('account_statements')
        .doc(parameters.companyToken)
        .collection('account_statements')
        .doc(parameters.apToken)
        .get()
        .then((value) => ApModel.fromJson(value.data()!, parameters.apToken));

    ApTableRow apTableRow = parameters.isKst
        ? apModel.apTableAksat.rows[parameters.index]
        : apModel.apTablePayments.rows[parameters.index];

    //Todo date time from grenetich

    ApTableRowModel apTableRowUpdated = ApTableRowModel(
        date: apTableRow.date,
        price: apTableRow.price,
        apTableRowBill: ApTableRowBill(
            token: apTableRow.apTableRowBill.token, date: DateTime.now()),
        aksatStatus: AksatStatus.done,
        isDone: true);

    if (parameters.isKst) {
      apModel.updateTableAksat(parameters.index, apTableRowUpdated);
    } else {
      apModel.updateTablePayments(parameters.index, apTableRowUpdated);
    }

    await FirebaseFirestore.instance
        .collection('account_statements')
        .doc(parameters.companyToken)
        .collection('account_statements')
        .doc(parameters.apToken)
        .update(apModel.toJson());

    return apModel;
  }
}
