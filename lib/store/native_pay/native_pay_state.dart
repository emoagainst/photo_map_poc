class NativePayState {
  final bool inProgress;
  final bool succeeded;
  final String? message;
  final int? photoId;

  const NativePayState({
    this.inProgress = false,
    this.succeeded = false,
    this.photoId,
    this.message,
  });

  NativePayState copyWith({bool? inProgress, bool? succeeded, int? photoId, String? message}) {
    return NativePayState(
      inProgress: inProgress ?? this.inProgress,
      succeeded: succeeded ?? this.succeeded,
      photoId: photoId ?? this.photoId,
      message: message ?? this.message,
    );
  }

  NativePayState clear() {
    return NativePayState(
      inProgress: false,
      succeeded: false,
      message: null,
      photoId: null,
    );
  }
}
