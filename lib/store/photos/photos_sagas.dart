import 'package:photo_map_poc/database/photo_dao.dart';
import 'package:photo_map_poc/database/photo_entity.dart';
import 'package:photo_map_poc/domain/models/photo_data.dart';
import 'package:photo_map_poc/store/geofence/geofence_actions.dart';
import 'package:photo_map_poc/store/photos/photos_actions.dart';
import 'package:redux_saga/redux_saga.dart';

import '../../main.dart';

photosSaga(PhotosDao dao) sync* {
  yield TakeEvery(_loadingPhotos, args: [dao], pattern: LoadingPhotosAction);
  yield TakeEvery(_deletePhotoDetails, args: [dao], pattern: DeletePhotoDetailsRequestedAction);
  yield TakeEvery(_savePhoto, args: [dao], pattern: SavePhotoAction);
}

_loadingPhotos(PhotosDao dao, {required LoadingPhotosAction action}) sync* {
  yield Try(() sync* {
    yield Put(LoadingPhotosRequestedAction());

    final result = Result<List<PhotoEntity>>();
    yield Call(dao.findAll, result: result);
    final photos = result.value?.map((entity) => PhotoData.fromEntity(entity)).toList() ?? <PhotoData>[];
    yield Put(LoadingPhotosSucceededAction(photos));
  }, Catch: (e, s) sync* {
    yield Put(LoadingPhotosFailedAction(e));
    logger.e("Exception caught:", e, s);
  });
}

_savePhoto(PhotosDao dao, {required SavePhotoAction action}) sync* {
  yield Try(() sync* {
    final photo = action.photo;
    yield Put(SavePhotoRequestedAction(photo));
    final photoIdResult = Result<int>();
    yield Call(dao.insert, args: [photo.toEntity()], result: photoIdResult);
    final updatedPhoto = photo.copyWith(id: photoIdResult.value);

    yield Put(SavePhotoSucceededAction(updatedPhoto));
    yield Put(SaveGeofenceAction(updatedPhoto));
    final result = Result<List<PhotoEntity>>();
    yield Call(dao.findAll, result: result);

    final photos = result.value?.map((entity) => PhotoData.fromEntity(entity)).toList() ?? <PhotoData>[];
    yield Put(LoadingPhotosSucceededAction(photos));
  }, Catch: (e, s) {
    logger.e("Exception caught:", e, s);
  });
}

_deletePhotoDetails(PhotosDao dao, {required DeletePhotoDetailsRequestedAction action}) sync* {
  yield Try(() sync* {
    yield Call(dao.delete, args: [action.id]);

    final result = Result<List<PhotoEntity>>();
    yield Call(dao.findAll, result: result);

    final photos = result.value?.map((entity) => PhotoData.fromEntity(entity)).toList() ?? <PhotoData>[];
    yield Put(LoadingPhotosSucceededAction(photos));
  }, Catch: (e, s) {
    logger.e("Exception caught:", e, s);
  });
}
