import 'package:photo_map_poc/database/photo_dao.dart';
import 'package:photo_map_poc/database/photo_entity.dart';
import 'package:photo_map_poc/domain/models/photo_data.dart';
import 'package:photo_map_poc/main.dart';
import 'package:photo_map_poc/store/photo_details/photo_details_actions.dart';
import 'package:photo_map_poc/store/photos/photos_actions.dart';
import 'package:redux_saga/redux_saga.dart';

photoDetailsSaga(PhotosDao photosDao) sync* {
  yield TakeEvery(_openPhotoDetails, pattern: OpenPhotoDetailsRequestedAction);
  yield TakeEvery(_loadingPhotoById, args: [photosDao], pattern: LoadingPhotoByIdAction);
}

_openPhotoDetails({required OpenPhotoDetailsRequestedAction action}) sync* {
  logger.d("_openPhotoDetails : ${action.id}");
  navigatorKey.currentState?.pushNamed("photos/${action.id}");
}

_loadingPhotoById(PhotosDao dao, {required LoadingPhotoByIdAction action}) sync* {
  yield Try(() sync* {
    yield Put(LoadingPhotoByIdRequestedAction(action.id));
    final result = Result<PhotoEntity?>();
    yield Call(dao.findById, args: [action.id], result: result);
    final photoEntity = result.value;
    if (photoEntity != null) {
      yield Put(LoadingPhotoByIdSucceededAction(PhotoData.fromEntity(photoEntity)));
    } else {
      yield Put(LoadingPhotoByIdFailedAction(Exception("Cannot find photo with id: ${action.id}")));
    }
  }, Catch: (e, s) {
    logger.e("Exception caught:", e, s);
  });
}
