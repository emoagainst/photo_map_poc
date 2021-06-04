class SubscriptionState {
  final String? message;

  const SubscriptionState({
    this.message});

  SubscriptionState copyWith({String? message}) {
    return SubscriptionState(
        message: message ?? this.message
    );
  }
}
