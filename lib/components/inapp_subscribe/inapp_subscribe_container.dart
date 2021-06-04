import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:photo_map_poc/components/inapp_subscribe/inapp_subscribe_widget.dart';
import 'package:photo_map_poc/store/selectors.dart';
import 'package:photo_map_poc/store/state.dart';
import 'package:photo_map_poc/store/subscription/subscription_actions.dart';
import 'package:redux/redux.dart';

class InAppSubscribe extends StatelessWidget {
  const InAppSubscribe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (store, vm) => InAppSubscribeWidget(
        onSubscribeRequested: vm.onSubscribeRequested,
      ),
    );
  }
}

class _ViewModel {
  final Function() onSubscribeRequested;

  _ViewModel({required this.onSubscribeRequested});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      onSubscribeRequested: () {
        final photoId = currentPhotoDetailsSelector(store.state.currentPhotoDetailsState).id!;
        store.dispatch(SubscribeAction(photoId));
      },
    );
  }
}
