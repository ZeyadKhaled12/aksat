
import '../../features/add_new_contract/domain/entities/contract.dart';

class GeneralFunctions {
  PriceAksatNumberOfKstKstDuration getPriceAksatNumberOfKstKstDuration({required Contract contract}) {
    double priceExtras = 0;
    for (var element in contract.extras) {
      priceExtras = priceExtras + element.price;
    }
    double priceAksat =
    (contract.totalPrice - (contract.paidUpPrice + priceExtras));
    double numberOfKst =
    contract.valueOfKst <= 0 ? 0 : priceAksat / contract.valueOfKst;
    double kstDuration = contract.valueOfKst <= 0 || contract.kstSystem <= 0
        ? 0
        : ((numberOfKst - 1) * contract.kstSystem) + 1;
    return PriceAksatNumberOfKstKstDuration(priceAksat: priceAksat,
        numberOfKst: numberOfKst, kstDuration: kstDuration);
  }
}

class PriceAksatNumberOfKstKstDuration{
  final double priceAksat;
  final double numberOfKst;
  final double kstDuration;

  PriceAksatNumberOfKstKstDuration({
    required this.priceAksat,
    required this.numberOfKst,
    required this.kstDuration
  });

}
