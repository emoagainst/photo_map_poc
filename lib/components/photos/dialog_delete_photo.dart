import 'package:flutter/material.dart';

class DeletePhotoDialogWidget extends StatelessWidget {
  final Function() onDeleteImage;

  const DeletePhotoDialogWidget({Key? key, required this.onDeleteImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remove image'),
      content: Text('Do you want to remove this picture from the grid?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Dismiss'),
          child: Text('Dismiss'),
        ),
        TextButton(
          onPressed: () {
            onDeleteImage();
            Navigator.pop(context, 'Remove');
          },
          child: Text('Remove'),
        )
      ],
    );
  }
}
