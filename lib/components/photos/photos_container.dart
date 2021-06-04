import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:photo_map_poc/components/photos/photos_screen.dart';
import 'package:photo_map_poc/domain/models/photo_data.dart';
import 'package:photo_map_poc/store/photo_details/photo_details_actions.dart';
import 'package:photo_map_poc/store/photos/photos_actions.dart';
import 'package:photo_map_poc/store/selectors.dart';
import 'package:photo_map_poc/store/state.dart';
import 'package:redux/redux.dart';

class PhotosContainer extends StatefulWidget {
  const PhotosContainer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PhotosContainerState();
  }
}

class _PhotosContainerState extends State<PhotosContainer> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => PhotosScreen(
        photos: vm.photos,
        loading: vm.loading,
        onInit: vm.onInit,
        onOpenPhotoDetailsRequestedAction: vm.onOpenPhotoDetailsRequested,
      ),
    );
  }
}

class _ViewModel {
  final List<PhotoData> photos;
  final bool loading;
  final Function() onInit;
  final Function(int) onOpenPhotoDetailsRequested;

  _ViewModel({
    required this.photos,
    required this.loading,
    required this.onInit,
    required this.onOpenPhotoDetailsRequested,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        photos: photosSelector(store.state.photosState),
        loading: photosLoadingSelector(store.state.photosState),
        onInit: () {
          store.dispatch(LoadingPhotosAction());
        },
        onOpenPhotoDetailsRequested: (id) {
          store.dispatch(OpenPhotoDetailsRequestedAction(id));
        });
  }
}
