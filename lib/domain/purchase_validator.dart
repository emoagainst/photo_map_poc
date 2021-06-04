import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:photo_map_poc/database/purchase_dao.dart';
import 'package:stripe_payment/stripe_payment.dart';


class PurchaseValidator {
  final PurchaseDao purchaseDao;

  PurchaseValidator(this.purchaseDao);

  bool verifyInApp(PurchaseDetails details){
    //TODO: Add verification handling
    return true;
  }

  bool verifyNativePay(Token token) {
    //TODO: Add verification handling
    return true;
  }
}
