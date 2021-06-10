import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:photo_map_poc/components/photos/dialog_delete_photo.dart';
import 'package:photo_map_poc/store/photos/photos_actions.dart';
import 'package:photo_map_poc/store/state.dart';
import 'package:redux/redux.dart';

class DeletePhotoDialog extends StatelessWidget {
  final int photoId;

  DeletePhotoDialog({Key? key, required this.photoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, photoId),
      builder: (context, vm) => DeletePhotoDialogWidget(
        onDeleteImage: vm.onDeletePhotoDetailsRequestedAction,
      ),
    );
  }
}

class _ViewModel {
  final Function() onDeletePhotoDetailsRequestedAction;

  _ViewModel({
    required this.onDeletePhotoDetailsRequestedAction,
  });

  static _ViewModel fromStore(Store<AppState> store, int photoId) {
    return _ViewModel(onDeletePhotoDetailsRequestedAction: () {
      store.dispatch(DeletePhotoDetailsRequestedAction(photoId));
    });
  }
}
