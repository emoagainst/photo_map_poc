import 'package:photo_map_poc/domain/models/photo_data.dart';

class OpenPhotoDetailsRequestedAction {
  final int id;

  OpenPhotoDetailsRequestedAction(this.id);
}

class LoadingPhotoByIdAction {
  final int id;

  LoadingPhotoByIdAction(this.id);
}

class LoadingPhotoByIdRequestedAction {
  final int id;

  LoadingPhotoByIdRequestedAction(this.id);
}

class LoadingPhotoByIdSucceededAction {
  final PhotoData photo;

  LoadingPhotoByIdSucceededAction(this.photo);
}

class LoadingPhotoByIdFailedAction {
  final Exception e;

  LoadingPhotoByIdFailedAction(this.e);
}
