import 'package:flutter/material.dart';

class InAppSubscribeWidget extends StatelessWidget {
  final Function() onSubscribeRequested;
  const InAppSubscribeWidget({Key? key, required this.onSubscribeRequested}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: AlignmentDirectional.center,
      child: ElevatedButton(
        onPressed: () => onSubscribeRequested(),
        child: Text("Subscribe"),
      ),
    );
  }
}
