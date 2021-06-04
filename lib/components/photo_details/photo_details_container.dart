import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:photo_map_poc/components/photo_details/photo_details_screen.dart';
import 'package:photo_map_poc/domain/models/photo_data.dart';
import 'package:photo_map_poc/store/photo_details/photo_details_actions.dart';
import 'package:photo_map_poc/store/selectors.dart';
import 'package:photo_map_poc/store/state.dart';
import 'package:redux/redux.dart';

class PhotoDetails extends StatefulWidget {
  final int photoId;

  const PhotoDetails({Key? key, required this.photoId}) : super(key: key);

  @override
  _PhotoDetailsState createState() => _PhotoDetailsState();
}

class _PhotoDetailsState extends State<PhotoDetails> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, widget.photoId),
      builder: (store, vm) => PhotoDetailsScreen(
        isLoading: vm.isLoading,
        photo: vm.photo,
        onInit: vm.onInit,
      ),
    );
  }
}

class _ViewModel {
  final bool isLoading;
  final PhotoData photo;
  final Function() onInit;

  _ViewModel({required this.isLoading, required this.photo, required this.onInit});

  static _ViewModel fromStore(Store<AppState> store, int photoId) {
    return _ViewModel(
      isLoading: currentPhotoDetailsLoadingSelector(store.state.currentPhotoDetailsState),
      photo: currentPhotoDetailsSelector(store.state.currentPhotoDetailsState),
      onInit: () {
        store.dispatch(LoadingPhotoByIdAction(photoId));
      },
    );
  }
}
