import 'package:photo_map_poc/store/photos/photos_actions.dart';
import 'package:photo_map_poc/store/photos/photos_states.dart';
import 'package:redux/redux.dart';

final photosReducer = combineReducers<PhotosState>([
  photosLoadingReducer,
  TypedReducer<PhotosState, LoadingPhotosSucceededAction>(_photosLoaded),
]);

PhotosState _photosLoaded(PhotosState state, LoadingPhotosSucceededAction action) {
  return state.copyWith(photos: action.photos);
}

final photosLoadingReducer = combineReducers<PhotosState>([
  TypedReducer<PhotosState, LoadingPhotosRequestedAction>(_setLoading),
  TypedReducer<PhotosState, LoadingPhotosSucceededAction>(_setLoading),
  TypedReducer<PhotosState, LoadingPhotosFailedAction>(_setLoading),

]);

PhotosState _setLoading(PhotosState state, action) {
  return state.copyWith(loading: action is LoadingPhotosRequestedAction);
}