import 'package:photo_map_poc/store/native_pay/native_pay_actions.dart';
import 'package:photo_map_poc/store/native_pay/native_pay_state.dart';
import 'package:redux/redux.dart';

final payReducer = combineReducers<NativePayState>([
  _payLoadingReducer,
  TypedReducer<NativePayState, PayRequestedAction>(_payCreating),
  TypedReducer<NativePayState, PaySucceededAction>(_paySucceeded)
]);

final _payLoadingReducer = combineReducers<NativePayState>([
  TypedReducer<NativePayState, PayRequestedAction>(_setLoading),
  TypedReducer<NativePayState, PaySucceededAction>(_setLoading),
  TypedReducer<NativePayState, PayCancelledAction>(_setLoading),
  TypedReducer<NativePayState, PayFailedAction>(_setLoading),

]);

NativePayState _setLoading(NativePayState state, action) {
  return state.copyWith(inProgress: action is PayRequestedAction);
}

NativePayState _payCreating(NativePayState state, PayRequestedAction action) {
  return state.clear().copyWith(photoId: action.photoId);
}

NativePayState _paySucceeded(NativePayState state, action) {
  return state.copyWith(succeeded: true);
}