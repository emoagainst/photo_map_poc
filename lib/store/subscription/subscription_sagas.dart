import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:photo_map_poc/domain/in_app_purchases_manager.dart';
import 'package:photo_map_poc/domain/purchase_validator.dart';
import 'package:photo_map_poc/store/subscription/subscription_actions.dart';
import 'package:redux_saga/redux_saga.dart';

subscribeSaga(InAppPurchasesManager manager, PurchaseValidator validator) sync* {
  yield TakeLatest(_subscribe, args: [manager, validator], pattern: SubscribeRequestedAction);
  yield TakeEvery(_updatePurchase, args: [manager, validator], pattern: PurchaseUpdatedAction);
}

_subscribe(InAppPurchasesManager manager, PurchaseValidator validator, {required SubscribeRequestedAction action}) sync* {
  yield Try(() sync* {
    final result = Result<String>();
    yield Call(manager.subscribe, result: result);
    yield Put(SubscribeSucceededAction(result.value!));
  }, Catch: (e, s) {
    print("Exception caught $e, $s");
  });
}

_updatePurchase(InAppPurchasesManager manager, PurchaseValidator validator, {required PurchaseUpdatedAction action}) sync* {
  yield Try(() sync* {
    final details = action.details;
    if (details.status == PurchaseStatus.pending) {
      //TODO: Add pending handling
    } else {
      if (details.status == PurchaseStatus.error) {
        //TODO: Add error handling
      } else if (details.status == PurchaseStatus.purchased || details.status == PurchaseStatus.restored) {
        bool valid = validator.verifyInApp(details);
        if (valid) {
          //TODO: Add success handling
        } else {
          //TODO: Add invalid handling
        }
        if (details.pendingCompletePurchase) {
          yield Call(InAppPurchase.instance.completePurchase, args: [details]);
        }
      }
    }
  }, Catch: (e, s) {
    print("Exception caught $e, $s");
  });
}
