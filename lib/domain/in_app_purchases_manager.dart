import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:photo_map_poc/domain/purchase_validator.dart';
import 'package:photo_map_poc/store/subscription/subscription_actions.dart';
import 'package:redux/redux.dart';

class InAppPurchasesManager {
  final Store store;
  final PurchaseValidator validator;

  late StreamSubscription<List<PurchaseDetails>> _subscription;

  InAppPurchasesManager(this.store, this.validator);

  init() {
    final purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        _subscription.cancel();
      },
      onError: (error) {},
    );
  }

  dispose() {
    _subscription.cancel();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((details) async {
      store.dispatch(PurchaseUpdatedAction(details));
    });
  }



  Future<String> subscribe() async {
    return Future<String>.value("Here should be Subscription related dialog");
    // final completer = Completer<String>();
    // completer.complete("Here should be Subscription related dialog");
    // return completer.future;
  }
}
