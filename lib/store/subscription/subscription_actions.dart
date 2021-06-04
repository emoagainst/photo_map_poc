import 'package:in_app_purchase/in_app_purchase.dart';

class SubscribeAction {
  final int photoId;

  SubscribeAction(this.photoId);
}

class SubscribeRequestedAction {
  final int photoId;

  SubscribeRequestedAction(this.photoId);
}

class SubscribeSucceededAction {
  final String message;

  SubscribeSucceededAction(this.message);
}

class SubscribeFailedAction {
  final Exception e;

  SubscribeFailedAction(this.e);
}

class PurchaseUpdatedAction {
  final PurchaseDetails details;

  PurchaseUpdatedAction(this.details);
}
