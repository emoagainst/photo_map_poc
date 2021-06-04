import 'package:flutter/services.dart';
import 'package:photo_map_poc/domain/payment_provider.dart';
import 'package:photo_map_poc/domain/purchase_validator.dart';
import 'package:photo_map_poc/store/native_pay/native_pay_actions.dart';
import 'package:redux_saga/redux_saga.dart';
import 'package:stripe_payment/stripe_payment.dart';

import '../../main.dart';

paySaga(PaymentProvider provider, PurchaseValidator validator) sync* {
  yield TakeLatest(_pay, args: [provider, validator], pattern: PayAction);
}

_pay(PaymentProvider provider, PurchaseValidator validator, {required PayAction action}) sync* {
  yield Try(
    () sync* {
      yield Put(PayRequestedAction(action.photoId));
      final tokenResult = Result<Token>();
      yield Call(provider.pay, args: ["0.01"], result: tokenResult);
      final token = tokenResult.value;
      logger.d("token: {${token?.tokenId}, ${token?.card?.name}");
      if (token == null){
        yield Put(PayFailedAction(action.photoId, Exception("Null token")));
        return;
      }
      final verificationResult = Result<bool>();
      yield Call(validator.verifyNativePay, args: [token], result: verificationResult);
      if (verificationResult.value != true) {
        yield Put(PayFailedAction(action.photoId, Exception("Pay failed")));
        return;
      }
      final completeResult = Result<void>();
      yield Call(provider.complete, result: completeResult);
      yield Put(PaySucceededAction(action.photoId));
    },
    Catch: (e, s) sync *{
      logger.e("Exception caught:", e, s);
      if (e is PlatformException) {
        final code = e.code;
        if (code == "purchaseCancelled") {
          yield Put(PayCancelledAction(action.photoId, e));
        }
      }
    },
  );
}
