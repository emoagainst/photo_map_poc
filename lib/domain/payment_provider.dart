import 'package:stripe_payment/stripe_payment.dart';

class PaymentProvider {
  final stripeOptions = StripeOptions(
      publishableKey: "pk_test_51ItBkMGzrFvyRYvXSJ3DW0kvjztlPJtBrx0dnyYi1N7uMXiqLFRBOntOuH8EW760LcM7fEiZK20CHH3w56h90kAw00vzrBqkNi",
      merchantId: "Test",
      androidPayMode: 'test');
  init() {

    StripePayment.setOptions(stripeOptions);
  }

  Future<Token> pay (String amount) {
    return StripePayment.paymentRequestWithNativePay(
        androidPayOptions: AndroidPayPaymentRequest(
          totalPrice: amount,
          currencyCode: "USD",
        ),
        applePayOptions: ApplePayPaymentOptions(countryCode: 'RU', currencyCode: 'USD', items: [
          ApplePayItem(
            label: 'Test',
            amount: amount,
          )
        ])
    );
  }
  Future<void> complete() {
    return StripePayment.completeNativePayRequest();
  }
}