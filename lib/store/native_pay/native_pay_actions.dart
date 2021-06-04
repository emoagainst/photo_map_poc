class PayAction {
  final int photoId;

  PayAction(this.photoId);
}



class PayRequestedAction {
  final int photoId;

  PayRequestedAction(this.photoId);
}

class PaySucceededAction {
  final int photoId;

  PaySucceededAction(this.photoId);
}

class PayCancelledAction {
  final int photoId;
  final Exception e;

  PayCancelledAction(this.photoId, this.e);
}

class PayFailedAction {
  final int photoId;
  final Exception e;

  PayFailedAction(this.photoId, this.e);
}

class PayClearAction {}

