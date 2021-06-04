import 'package:flutter/material.dart';
import 'package:photo_map_poc/widgets/loading_indicator.dart';

class NativePayWidget extends StatelessWidget {
  final Function() onPayRequested;
  final bool inProgress;
  final bool succedeed;

  const NativePayWidget({Key? key, required this.onPayRequested, required this.inProgress, required this.succedeed}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    if (inProgress) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 16,
          ),
          LoadingIndicator(),
        ],
      );
    }
    if (succedeed) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text("Thank you for your support"),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text("Love it? Buy it!"),
        ),
        SizedBox(
          width: double.infinity,
          height: 16,
        ),
        Container(
          width: double.infinity,
          alignment: AlignmentDirectional.center,
          child: ElevatedButton(
            onPressed: () => onPayRequested(),
            child: Text("Google Pay"),
          ),
        ),
      ],
    );
  }
}
