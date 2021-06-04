import 'package:image_picker/image_picker.dart';
import 'package:photo_map_poc/database/photo_dao.dart';
import 'package:photo_map_poc/domain/geofence_manager.dart';
import 'package:photo_map_poc/domain/in_app_purchases_manager.dart';
import 'package:photo_map_poc/domain/payment_provider.dart';
import 'package:photo_map_poc/domain/purchase_validator.dart';
import 'package:photo_map_poc/store/geofence/geofence_sagas.dart';
import 'package:photo_map_poc/store/image_metadata/image_metadata_sagas.dart';
import 'package:photo_map_poc/store/image_picker/image_picker_sagas.dart';
import 'package:photo_map_poc/store/native_pay/native_pay_sagas.dart';
import 'package:photo_map_poc/store/photo_details/photo_details_sagas.dart';
import 'package:photo_map_poc/store/photos/photos_sagas.dart';
import 'package:photo_map_poc/store/subscription/subscription_sagas.dart';
import 'package:redux_saga/redux_saga.dart';

rootSaga(PhotosDao dao, ImagePicker picker, GeofenceManager geofenceManager, PaymentProvider paymentProvider, InAppPurchasesManager subscriptionsManager, PurchaseValidator validator) sync* {
  yield Fork(photoDetailsSaga, args: [dao]);
  yield Fork(photosSaga, args: [dao]);
  yield Fork(imagePickerSaga, args: [picker]);
  yield Fork(metadataSaga);
  yield Fork(geofenceSaga, args: [geofenceManager]);
  yield Fork(paySaga, args: [paymentProvider, validator]);
  yield Fork(subscribeSaga, args: [subscriptionsManager, validator]);
}
