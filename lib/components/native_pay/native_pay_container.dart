import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:photo_map_poc/components/native_pay/native_pay_widget.dart';
import 'package:photo_map_poc/store/native_pay/native_pay_actions.dart';
import 'package:photo_map_poc/store/selectors.dart';
import 'package:photo_map_poc/store/state.dart';
import 'package:redux/redux.dart';

class NativePay extends StatelessWidget {
  const NativePay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (store, vm) => NativePayWidget(
        inProgress: vm.inProgress,
        succedeed: vm.succeeded,
        onPayRequested: vm.onPayRequested,
      ),
    );
  }
}

class _ViewModel {
  final Function() onPayRequested;
  final Function() onPayCleared;
  final bool inProgress;
  final bool succeeded;

  _ViewModel({required this.inProgress, required this.succeeded, required this.onPayRequested, required this.onPayCleared});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      inProgress: currentNativePayInProgressSelector(store.state.currentPayState),
      succeeded: currentNativePaySucceededSelector(store.state.currentPayState),
      onPayRequested: () {
        final photoId = currentPhotoDetailsSelector(store.state.currentPhotoDetailsState).id!;
        store.dispatch(PayAction(photoId));
      },
        onPayCleared: () {
          store.dispatch(PayClearAction());
        }
    );
  }
}