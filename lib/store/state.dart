import 'package:photo_map_poc/store/native_pay/native_pay_state.dart';
import 'package:photo_map_poc/store/photo_details/photo_details_states.dart';
import 'package:photo_map_poc/store/photos/photos_states.dart';
import 'package:photo_map_poc/store/subscription/subscription_state.dart';

class AppState {
  final bool isAnyPhotoAdded;
  final PhotosState photosState;
  final PhotoDetailsState currentPhotoDetailsState;
  final SubscriptionState currentSubscriptionState;
  final NativePayState currentPayState;

  const AppState({
    this.isAnyPhotoAdded = true,
    this.photosState = const PhotosState(),
    this.currentPhotoDetailsState = const PhotoDetailsState(),
    this.currentSubscriptionState = const SubscriptionState(),
    this.currentPayState = const NativePayState(),
  });
}




