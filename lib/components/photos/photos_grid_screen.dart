import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_map_poc/common/widget_keys.dart';
import 'package:photo_map_poc/components/photo_source_picker/photo_source_picker_container.dart';
import 'package:photo_map_poc/domain/models/photo_data.dart';
import 'package:photo_map_poc/widgets/loading_indicator.dart';

class PhotosGridScreen extends StatefulWidget {
  final List<PhotoData> photos;
  final bool loading;
  final Function() onInit;
  final Function(int) onOpenPhotoDetailsRequestedAction;
  final Function(int) onDeletePhotoDetailsRequestedAction;

  const PhotosGridScreen({
    Key? key,
    required this.photos,
    required this.loading,
    required this.onInit,
    required this.onOpenPhotoDetailsRequestedAction,
    required this.onDeletePhotoDetailsRequestedAction,
  }) : super(key: key);

  @override
  _PhotosGridScreenState createState() => _PhotosGridScreenState();
}

class _PhotosGridScreenState extends State<PhotosGridScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Photos")),
      body: Builder(builder: (context) {
        if (widget.photos.isEmpty) {
          return PhotoSourcePicker();
        }
        if (widget.loading) {
          return LoadingIndicator();
        }
        return GridView.count(
          primary: false,
          key: Keys.photosGrid,
          controller: _scrollController,
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: List.generate(
            widget.photos.length + 1,
            (index) {
              if (index == widget.photos.length) {
                return PhotoSourcePicker();
              }
              final photo = widget.photos[index];
              return SizedBox.expand(
                key: Key("__photoItem_${photo.id}__"),
                child: InkWell(
                  onLongPress: () => widget.onDeletePhotoDetailsRequestedAction(photo.id!),
                  onTap: () => widget.onOpenPhotoDetailsRequestedAction(photo.id!),
                  child: Image.file(
                    File(photo.path),
                    fit: BoxFit.cover,
                    cacheWidth: 200, // use to faster loading an image into grid
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
