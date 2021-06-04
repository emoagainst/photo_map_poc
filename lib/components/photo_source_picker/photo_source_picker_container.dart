import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:photo_map_poc/components/photo_source_picker/photo_source_picker_widget.dart';
import 'package:photo_map_poc/store/image_picker/image_picker_actions.dart';
import 'package:photo_map_poc/store/state.dart';
import 'package:redux/redux.dart';

class PhotoSourcePicker extends StatelessWidget {
  const PhotoSourcePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => PhotoSourcePickerWidget(
        onOpenCameraRequested: vm.onOpenCameraRequested,
        onOpenGalleryRequested: vm.onOpenGalleryRequested,
      ),
    );
  }
}

class _ViewModel {
  final Function() onOpenCameraRequested;
  final Function() onOpenGalleryRequested;

  _ViewModel({
    required this.onOpenCameraRequested,
    required this.onOpenGalleryRequested,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      onOpenCameraRequested: () {
        store.dispatch(OpenCameraRequestedAction());
      },
      onOpenGalleryRequested: () {
        store.dispatch(OpenGalleryRequestedAction());
      },
    );
  }
}
