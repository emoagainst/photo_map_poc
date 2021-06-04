import 'package:photo_map_poc/store/native_pay/native_pay_reducer.dart';
import 'package:photo_map_poc/store/photo_details/photo_details_reducers.dart';
import 'package:photo_map_poc/store/photos/photos_reducers.dart';
import 'package:photo_map_poc/store/state.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    photosState: photosReducer(state.photosState, action),
    currentPhotoDetailsState: photoDetailsReducer(state.currentPhotoDetailsState, action),
    currentPayState: payReducer(state.currentPayState, action),
  );
}



