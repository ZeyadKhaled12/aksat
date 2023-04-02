
import '../../../../core/utils/enums.dart';
import '../../domain/entities/contract.dart';
import '../../domain/usecases/update_anc_info_uc.dart';

abstract class BaseAncLocalDataSource {
  Contract updateAncInfo(UpdateAncInfoParameters updateAncInfoParameters);
}

class AncLocalDataSource extends BaseAncLocalDataSource {
  @override
  Contract updateAncInfo(UpdateAncInfoParameters updateAncInfoParameters) {
    switch (updateAncInfoParameters.ancInfoKeys) {
      case AncInfoKeys.customerName:
        return Contract(
            customerName: updateAncInfoParameters.text!,
            phoneNumber: updateAncInfoParameters.contract.phoneNumber,
            productType: updateAncInfoParameters.contract.productType,
            totalPrice: updateAncInfoParameters.contract.totalPrice,
            paidUpPrice: updateAncInfoParameters.contract.paidUpPrice,
            extras: updateAncInfoParameters.contract.extras,
            valueOfKst: updateAncInfoParameters.contract.valueOfKst,
            kstSystem: updateAncInfoParameters.contract.kstSystem,
            startDate: updateAncInfoParameters.contract.startDate);
      case AncInfoKeys.phoneNumber:
        return Contract(
            customerName: updateAncInfoParameters.contract.customerName,
            phoneNumber: updateAncInfoParameters.text!,
            productType: updateAncInfoParameters.contract.productType,
            totalPrice: updateAncInfoParameters.contract.totalPrice,
            extras: updateAncInfoParameters.contract.extras,
            paidUpPrice: updateAncInfoParameters.contract.paidUpPrice,
            valueOfKst: updateAncInfoParameters.contract.valueOfKst,
            kstSystem: updateAncInfoParameters.contract.kstSystem,
            startDate: updateAncInfoParameters.contract.startDate);
      case AncInfoKeys.productType:
        return Contract(
            customerName: updateAncInfoParameters.contract.customerName,
            phoneNumber: updateAncInfoParameters.contract.phoneNumber,
            productType: updateAncInfoParameters.text!,
            totalPrice: updateAncInfoParameters.contract.totalPrice,
            paidUpPrice: updateAncInfoParameters.contract.paidUpPrice,
            extras: updateAncInfoParameters.contract.extras,
            valueOfKst: updateAncInfoParameters.contract.valueOfKst,
            kstSystem: updateAncInfoParameters.contract.kstSystem,
            startDate: updateAncInfoParameters.contract.startDate);
      case AncInfoKeys.totalPrice:
        return Contract(
            customerName: updateAncInfoParameters.contract.customerName,
            phoneNumber: updateAncInfoParameters.contract.phoneNumber,
            productType: updateAncInfoParameters.contract.productType,
            totalPrice: updateAncInfoParameters.amount!,
            extras: updateAncInfoParameters.contract.extras,
            paidUpPrice: updateAncInfoParameters.contract.paidUpPrice,
            valueOfKst: updateAncInfoParameters.contract.valueOfKst,
            kstSystem: updateAncInfoParameters.contract.kstSystem,
            startDate: updateAncInfoParameters.contract.startDate);
      case AncInfoKeys.paidUpPrice:
        return Contract(
            customerName: updateAncInfoParameters.contract.customerName,
            phoneNumber: updateAncInfoParameters.contract.phoneNumber,
            productType: updateAncInfoParameters.contract.productType,
            extras: updateAncInfoParameters.contract.extras,
            totalPrice: updateAncInfoParameters.contract.totalPrice,
            paidUpPrice: updateAncInfoParameters.amount!,
            valueOfKst: updateAncInfoParameters.contract.valueOfKst,
            kstSystem: updateAncInfoParameters.contract.kstSystem,
            startDate: updateAncInfoParameters.contract.startDate);
      case AncInfoKeys.valueOfKst:
        return Contract(
            customerName: updateAncInfoParameters.contract.customerName,
            phoneNumber: updateAncInfoParameters.contract.phoneNumber,
            productType: updateAncInfoParameters.contract.productType,
            totalPrice: updateAncInfoParameters.contract.totalPrice,
            paidUpPrice: updateAncInfoParameters.contract.paidUpPrice,
            extras: updateAncInfoParameters.contract.extras,
            valueOfKst: updateAncInfoParameters.amount!,
            kstSystem: updateAncInfoParameters.contract.kstSystem,
            startDate: updateAncInfoParameters.contract.startDate);
      case AncInfoKeys.kstSystem:
        return Contract(
            customerName: updateAncInfoParameters.contract.customerName,
            phoneNumber: updateAncInfoParameters.contract.phoneNumber,
            productType: updateAncInfoParameters.contract.productType,
            totalPrice: updateAncInfoParameters.contract.totalPrice,
            paidUpPrice: updateAncInfoParameters.contract.paidUpPrice,
            extras: updateAncInfoParameters.contract.extras,
            valueOfKst: updateAncInfoParameters.contract.valueOfKst,
            kstSystem: updateAncInfoParameters.amount!.toInt(),
            startDate: updateAncInfoParameters.contract.startDate);
      case AncInfoKeys.startDate:
        return Contract(
            customerName: updateAncInfoParameters.contract.customerName,
            phoneNumber: updateAncInfoParameters.contract.phoneNumber,
            productType: updateAncInfoParameters.contract.productType,
            totalPrice: updateAncInfoParameters.contract.totalPrice,
            paidUpPrice: updateAncInfoParameters.contract.paidUpPrice,
            valueOfKst: updateAncInfoParameters.contract.valueOfKst,
            extras: updateAncInfoParameters.contract.extras,
            kstSystem: updateAncInfoParameters.contract.kstSystem,
            startDate: updateAncInfoParameters.dateTime);
      case AncInfoKeys.extra:
        return Contract(
            customerName: updateAncInfoParameters.contract.customerName,
            phoneNumber: updateAncInfoParameters.contract.phoneNumber,
            productType: updateAncInfoParameters.contract.productType,
            totalPrice: updateAncInfoParameters.contract.totalPrice,
            paidUpPrice: updateAncInfoParameters.contract.paidUpPrice,
            valueOfKst: updateAncInfoParameters.contract.valueOfKst,
            extras: updateAncInfoParameters.extras!,
            kstSystem: updateAncInfoParameters.contract.kstSystem,
            startDate: updateAncInfoParameters.contract.startDate);
    }
  }
}
