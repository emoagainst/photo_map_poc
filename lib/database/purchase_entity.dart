class PurchaseEntity {
  final int? id;
  final String token;
  final PurchaseStateEntity state;

  PurchaseEntity({required this.id, required this.token, required this.state});
}

enum PurchaseStateEntity { idle, in_progress, pending, succeeded, failed }
