import 'dart:io';

import 'package:exif/exif.dart';
import 'package:geolocator/geolocator.dart';
import 'package:photo_map_poc/domain/lat_lon_parser.dart';
import 'package:photo_map_poc/domain/models/photo_data.dart';
import 'package:photo_map_poc/store/image_metadata/image_metadata_actions.dart';
import 'package:photo_map_poc/store/photos/photos_actions.dart';
import 'package:redux_saga/redux_saga.dart';

import '../../main.dart';

metadataSaga() sync* {
  yield TakeEvery(_extractMetadata, pattern: ExtractMetadataRequestedAction);
}

_extractMetadata({required ExtractMetadataRequestedAction action}) sync* {
  yield Try(() sync* {
    final path = action.path;
    logger.d("Try extract meta from $path");
    final exifResult = Result<Map<String?, IfdTag>?>();
    yield Call(readExifFromFile, args: [File(path)], result: exifResult);
    final data = exifResult.value;
    if (data == null || data.isEmpty) {
      logger.d("No EXIF information found");
      return;
    }

    const latitudeKey = "GPS GPSLatitude";
    const longitudeKey = "GPS GPSLongitude";

    final latitudeTag = data[latitudeKey];
    final longitudeTag = data[longitudeKey];

    double latitude, longitude;
    if (latitudeTag == null || longitudeTag == null) {
      final positionResult = Result<Position>();
      yield Call(Geolocator.getCurrentPosition, result: positionResult);
      final position = positionResult.value!;
      latitude = position.latitude;
      longitude = position.longitude;
    } else {
      latitude = parseLatLon(latitudeTag);
      longitude = parseLatLon(longitudeTag);
    }

    final photoData = PhotoData(
      id: null,
      path: path,
      latitude: latitude,
      longitude: longitude,
      isPaid: false,
    );
    yield Put(SavePhotoAction(photoData));
  }, Catch: (e, s) {
    logger.e("Exception caught:", e, s);
  });
}
