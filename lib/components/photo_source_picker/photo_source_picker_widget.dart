import 'package:flutter/material.dart';

class PhotoSourcePickerWidget extends StatelessWidget {
  final Function() onOpenCameraRequested;
  final Function() onOpenGalleryRequested;

  PhotoSourcePickerWidget({
    Key? key,
    required this.onOpenCameraRequested,
    required this.onOpenGalleryRequested,
  }) : super(key: key);

  void _onAddPhotoPressed(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              ListTile(
                title: Text('Choose photo source'),
              ),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Open camera'),
                onTap: onOpenCameraRequested,
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Add from gallery'),
                onTap: onOpenGalleryRequested,
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => _onAddPhotoPressed(context),
        child: Column(
          children: [
            Icon(
              Icons.add,
              size: 48,
            ),
            Divider(
              height: 16,
            ),
            Text("Add Photo"),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
