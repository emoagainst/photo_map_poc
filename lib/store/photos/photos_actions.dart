
import '../../domain/models/photo_data.dart';

class LoadingPhotosAction{}

class LoadingPhotosRequestedAction{}

class LoadingPhotosSucceededAction {
  final List<PhotoData> photos;

  LoadingPhotosSucceededAction(this.photos);
}

class LoadingPhotosFailedAction {
  final Exception e;

  LoadingPhotosFailedAction(this.e);
}

class SavePhotoAction {
  final PhotoData photo;

  SavePhotoAction(this.photo);
}

class SavePhotoRequestedAction {
  final PhotoData photo;

  SavePhotoRequestedAction(this.photo);
}

class SavePhotoSucceededAction {
  final PhotoData photo;

  SavePhotoSucceededAction(this.photo);
}

class SavePhotoFailedAction {
  final Exception e;

  SavePhotoFailedAction(this.e);
}