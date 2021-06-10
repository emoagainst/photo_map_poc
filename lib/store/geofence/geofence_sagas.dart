import 'package:photo_map_poc/domain/geofence_manager.dart';
import 'package:photo_map_poc/store/geofence/geofence_actions.dart';
import 'package:redux_saga/redux_saga.dart';

import '../../main.dart';

geofenceSaga(GeofenceManager geofenceManager) sync* {
  yield TakeEvery(_saveGeofence, args: [geofenceManager], pattern: SaveGeofenceAction);
}

_saveGeofence(GeofenceManager geofenceManager, {required SaveGeofenceAction action}) sync* {
  yield Try(() sync* {
    yield Call(geofenceManager.addGeolocationForPhoto, args: [action.photo]);
  }, Catch: (e, s) {
    logger.e("Exception caught:", e, s);
  });
}
