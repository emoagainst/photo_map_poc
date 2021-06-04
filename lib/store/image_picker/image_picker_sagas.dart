import 'package:image_picker/image_picker.dart';
import 'package:photo_map_poc/domain/geofence_manager.dart';
import 'package:photo_map_poc/main.dart';
import 'package:photo_map_poc/store/image_metadata/image_metadata_actions.dart';
import 'package:photo_map_poc/store/image_picker/image_picker_actions.dart';
import 'package:redux_saga/redux_saga.dart';

imagePickerSaga(ImagePicker picker) sync* {
  yield TakeEvery(_openCamera, args: [picker], pattern: OpenCameraRequestedAction);
  yield TakeEvery(_openGallery, args: [picker], pattern: OpenGalleryRequestedAction);
}

_openCamera(ImagePicker picker, {required OpenCameraRequestedAction action}) sync* {
  yield Try(() sync* {
    navigatorKey.currentState?.pop();

    yield Call(requestLocationPermissions);

    final result = Result<PickedFile>();
    yield Call(picker.getImage, namedArgs: {Symbol('source'): ImageSource.camera}, result: result);
    final photoUri = result.value?.path;
    if (photoUri == null) {
      return;
    }
    yield Put(ExtractMetadataRequestedAction(photoUri));
  }, Catch: (e, s) {
    logger.e("Exception caught:", e, s);
  });
}

_openGallery(ImagePicker picker, {required OpenGalleryRequestedAction action}) sync* {
  yield Try(() sync* {
    navigatorKey.currentState?.pop();
    final result = Result<PickedFile>();
    yield Call(picker.getImage, namedArgs: {Symbol('source'): ImageSource.gallery}, result: result);
    final photoUri = result.value?.path;
    if (photoUri == null) {
      return;
    }
    yield Put(ExtractMetadataRequestedAction(photoUri));
  }, Catch: (e, s) {
    logger.e("Exception caught:", e, s);
  });
}
