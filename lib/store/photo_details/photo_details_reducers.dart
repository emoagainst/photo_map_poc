import 'package:photo_map_poc/store/photo_details/photo_details_actions.dart';
import 'package:photo_map_poc/store/photo_details/photo_details_states.dart';
import 'package:redux/redux.dart';

final photoDetailsReducer = combineReducers<PhotoDetailsState>([
  photoDetailsLoadingReducer,
  TypedReducer<PhotoDetailsState, LoadingPhotoByIdSucceededAction>(_photoDetailsLoaded)
]);

PhotoDetailsState _photoDetailsLoaded(PhotoDetailsState state, LoadingPhotoByIdSucceededAction action) {
  return state.copyWith(photo: action.photo);
}

final photoDetailsLoadingReducer = combineReducers<PhotoDetailsState>([
  TypedReducer<PhotoDetailsState, LoadingPhotoByIdRequestedAction>(_setLoading),
  TypedReducer<PhotoDetailsState, LoadingPhotoByIdSucceededAction>(_setLoading),
  TypedReducer<PhotoDetailsState, LoadingPhotoByIdFailedAction>(_setLoading),
]);

PhotoDetailsState _setLoading(PhotoDetailsState state, action) {
  return state.copyWith(loading: action is LoadingPhotoByIdRequestedAction);
}