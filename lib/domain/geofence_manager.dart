import 'dart:math';

import 'package:flutter_geofence/geofence.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:photo_map_poc/domain/models/photo_data.dart';

class GeofenceManager {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final _initializationSettingsAndroid = new AndroidInitializationSettings('ic_launcher');
  final _initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: null);

  void init() {
    print("GeofenceManager init");
    final initializationSettings = InitializationSettings(android: _initializationSettingsAndroid, iOS: _initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: null);

    Geofence.initialize();
    Geofence.requestPermissions();
    listenToGeofences();
    listenToLocationUpdates();
  }

  void listenToGeofences() {
    Geofence.startListening(GeolocationEvent.entry, (entry) {
      print("Entry of a georegion. Welcome to: ${entry.id}");
      _scheduleNotification("Entry of a georegion", "Welcome to: ${entry.id}");
    });
    Geofence.startListening(GeolocationEvent.exit, (entry) {
      print("Exit of a georegion. Welcome to: ${entry.id}");
      _scheduleNotification("Exit of a georegion", "Byebye to: ${entry.id}");
    });
  }

  void listenToLocationUpdates() {
    Geofence.startListeningForLocationChanges();
    Geofence.backgroundLocationUpdated.stream.listen((coordinate) {
      print("Location changed to ${coordinate.latitude}: ${coordinate.longitude}");
      _scheduleNotification("Location changed", "Location changed to ${coordinate.latitude}: ${coordinate.longitude}");
    });
}

  _scheduleNotification(String title, String subtitle) {
    print("scheduling one with $title and $subtitle");
    var rng = new Random();
    Future.delayed(Duration(seconds: 1)).then((result) async {
      var androidPlatformChannelSpecifics =
          AndroidNotificationDetails('your channel id', 'your channel name', 'your channel description', importance: Importance.high, priority: Priority.high, ticker: 'ticker');
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
      await _flutterLocalNotificationsPlugin.show(rng.nextInt(100000), title, subtitle, platformChannelSpecifics, payload: 'item x');
    });
  }

  addGeolocationForPhoto(PhotoData photo) async {

      await Geofence.addGeolocation(
          Geolocation(
            latitude: photo.latitude,
            longitude: photo.longitude,
            radius: 200,
            id: "Photo ${photo.id}",
          ),
          GeolocationEvent.entry);
      _scheduleNotification("Georegion added", "Your geofence has been added!");
  }
}

 Future<void> requestLocationPermissions() async {
  print("requestLocationPermissions");
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    print("Location services are disabled.");
    return;
  }
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print("Location permissions are denied.");
      return;
    }
  }
}
