import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:photo_map_poc/domain/models/photo_data.dart';

import '../main.dart';
import 'package:geofencing/geofencing.dart';

class GeofenceManager {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final _initializationSettingsAndroid = new AndroidInitializationSettings('ic_launcher');
  final _initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: null);

  final port = ReceivePort();

  final triggers = <GeofenceEvent>[GeofenceEvent.enter, GeofenceEvent.exit, GeofenceEvent.dwell];

  final androidSettings = AndroidGeofencingSettings(
    initialTrigger: <GeofenceEvent>[GeofenceEvent.enter, GeofenceEvent.exit, GeofenceEvent.dwell],
    loiteringDelay: 1000 * 60,
  );

  static void callback(List<String> ids, Location l, GeofenceEvent e) async {
    print('Fences: $ids Location $l Event: $e');
    final SendPort? send = IsolateNameServer.lookupPortByName('geofencing_send_port');
    send?.send(e.toString());
  }

  Future<void> init() async {
    logger.d("GeofenceManager init");
    final initializationSettings = InitializationSettings(android: _initializationSettingsAndroid, iOS: _initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: null);

    IsolateNameServer.registerPortWithName(port.sendPort, 'geofencing_send_port');
    port.listen((data) {
      logger.d('Event $data');
    });

    logger.d('Initializing geofence manager...');
    await GeofencingManager.initialize();
    logger.d('Initialization done');
  }

  _scheduleNotification(String title, String subtitle) {
    logger.d("scheduling one with $title and $subtitle");
    var rng = new Random();
    Future.delayed(Duration(seconds: 1)).then((result) async {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        'your channel description',
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker',
      );
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
      await _flutterLocalNotificationsPlugin.show(rng.nextInt(100000), title, subtitle, platformChannelSpecifics, payload: 'item x');
    });
  }

  addGeolocationForPhoto(PhotoData photo) async {
    GeofencingManager.registerGeofence(
      GeofenceRegion(
        id: "Photo ${photo.id}",
        latitude: photo.latitude,
        longitude: photo.longitude,
        radius: 200,
        triggers: triggers,
        androidSettings: androidSettings,
      ),
      callback,
    );
    _scheduleNotification("Georegion added", "Your geofence has been added!");
  }
}

Future<void> requestLocationPermissions() async {
  logger.d("requestLocationPermissions");
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    logger.d("Location services are disabled.");
    return;
  }
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      logger.d("Location permissions are denied.");
      return;
    }
  }
}
