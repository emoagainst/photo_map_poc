
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:photo_map_poc/components/photo_details/photo_details_container.dart';
import 'package:photo_map_poc/components/photos/photos_grid_container.dart';

void defineRoutes(FluroRouter router) {
  router.define("/", handler: photosHandler);
  router.define("/photos/:id", handler: photoDetailsHandler);
}

final photosHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return PhotosGrid();
});

final photoDetailsHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  final photoId = int.parse(parameters['id']![0]);
  return PhotoDetails(photoId: photoId);
});

