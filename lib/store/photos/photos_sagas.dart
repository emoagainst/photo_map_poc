import 'package:photo_map_poc/database/photo_dao.dart';
import 'package:photo_map_poc/database/photo_entity.dart';
import 'package:photo_map_poc/domain/models/photo_data.dart';
import 'package:photo_map_poc/store/geofence/geofence_actions.dart';
import 'package:photo_map_poc/store/photos/photos_actions.dart';
import 'package:redux_saga/redux_saga.dart';

photosSaga(PhotosDao dao) sync* {
  yield TakeLatest(_loadingPhotos, args: [dao], pattern: LoadingPhotosAction);
  yield TakeEvery(_savePhoto, args: [dao], pattern: SavePhotoAction);
}

_loadingPhotos(PhotosDao dao, {required LoadingPhotosAction action}) sync* {
  yield Try(() sync* {
    yield Put(LoadingPhotosRequestedAction());

    final result = Result<List<PhotoEntity>>();
    yield Call(
      dao.findAll,
      name: "dao.findAll",
      result: result,
      Catch: (e) sync* {
        yield Put(LoadingPhotosFailedAction(e));
      },
    );

    final photos = result.value?.map((entity) => PhotoData.fromEntity(entity)).toList() ?? <PhotoData>[];
    yield Put(LoadingPhotosSucceededAction(photos));
  }, Catch: (e, s) {
    print("Exception caught $e, $s");
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
    yield Put((SaveGeofenceAction(updatedPhoto)));
    yield Put((LoadingPhotosAction()));
  }, Catch: (e, s) {
    print("Exception caught $e, $s");
  });
}
