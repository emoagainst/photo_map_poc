import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:logger/logger.dart';
import 'package:photo_map_poc/application.dart';
import 'package:photo_map_poc/database/database.dart';
import 'package:photo_map_poc/database/photo_dao.dart';
import 'package:photo_map_poc/database/purchase_dao.dart';
import 'package:photo_map_poc/domain/geofence_manager.dart';
import 'package:photo_map_poc/domain/in_app_purchases_manager.dart';
import 'package:photo_map_poc/domain/payment_provider.dart';
import 'package:photo_map_poc/domain/purchase_validator.dart';
import 'package:photo_map_poc/routes.dart';
import 'package:photo_map_poc/store/reducers.dart';
import 'package:photo_map_poc/store/sagas.dart';
import 'package:photo_map_poc/store/state.dart';
import 'package:redux/redux.dart';
import 'package:redux_saga/redux_saga.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android) {
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  }

  final database = await createDatabase();
  final photosDao = PhotosDao(database);
  final purchaseDao = PurchaseDao(database);

  final sagaMiddleware = createSagaMiddleware();
  final store = Store<AppState>(
      appReducer,
      initialState: AppState(),
      middleware: [applyMiddleware(sagaMiddleware)],
  );

  sagaMiddleware.setStore(store);

  final imagePicker = ImagePicker();
  final geofenceManager = GeofenceManager();
  await geofenceManager.init();
  final purchaseValidator = PurchaseValidator(purchaseDao);
  final paymentProvider = PaymentProvider();
  paymentProvider.init();
  final subscriptionsManager = InAppPurchasesManager(store, purchaseValidator);
  subscriptionsManager.init();


  sagaMiddleware.run(rootSaga, args: [photosDao, imagePicker, geofenceManager, paymentProvider, subscriptionsManager, purchaseValidator]);

  final router = FluroRouter();
  defineRoutes(router);

  runApp(MyApp(
    store: store,
    router: router,
  ));
}
