import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photo_map_poc/components/inapp_subscribe/inapp_subscribe_container.dart';
import 'package:photo_map_poc/components/native_pay/native_pay_container.dart';
import 'package:photo_map_poc/domain/models/photo_data.dart';
import 'package:photo_map_poc/widgets/loading_indicator.dart';

class PhotoDetailsScreen extends StatefulWidget {
  final bool isLoading;
  final PhotoData photo;
  final Function() onInit;

  const PhotoDetailsScreen({Key? key, required this.isLoading, required this.photo, required this.onInit}) : super(key: key);

  @override
  _PhotoDetailsScreenState createState() => _PhotoDetailsScreenState();
}

class _PhotoDetailsScreenState extends State<PhotoDetailsScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Function(AnimationStatus)? animationStatusListener;
  late ModalRoute<dynamic> route;
  bool _showGoogleMap = false;

  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    if (animationStatusListener != null) route?.animation?.removeStatusListener(animationStatusListener!);
    animationStatusListener = (status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showGoogleMap = true;
        });
        route?.animation?.removeStatusListener(animationStatusListener!);
      }
    };
    route?.animation?.addStatusListener(animationStatusListener!);
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Builder(
        builder: (BuildContext context) {
          if (widget.isLoading) {
            return LoadingIndicator();
          }
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.file(
                    File(widget.photo.path),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "This photo captured here:",
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 16,
                ),
                SizedBox(
                  height: 96,
                  width: double.infinity,
                  child: Builder(
                    builder: (context) {
                      if (_showGoogleMap) {
                        return GoogleMap(
                          mapType: MapType.hybrid,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(widget.photo.latitude, widget.photo.longitude),
                            zoom: 14,
                          ),
                          onMapCreated: (controller) {
                            _controller.complete(controller);
                          },
                          mapToolbarEnabled: false,
                          myLocationButtonEnabled: false,
                          myLocationEnabled: true,
                          zoomControlsEnabled: false,
                          zoomGesturesEnabled: false,
                          scrollGesturesEnabled: false,
                          markers: Set<Marker>.of([
                            Marker(
                              markerId: MarkerId(widget.photo.id.toString()),
                              position: LatLng(widget.photo.latitude, widget.photo.longitude),
                            )
                          ]),
                          circles: Set<Circle>.of([
                            Circle(
                              circleId: CircleId(widget.photo.id.toString()),
                              radius: 200,
                              center: LatLng(widget.photo.latitude, widget.photo.longitude),
                            ),
                          ]),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 16,
                ),
                NativePay(),
                SizedBox(
                  width: double.infinity,
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Or subscribe to this photographer"),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 16,
                ),
                InAppSubscribe(),
              ],
            ),
          );
        },
      ),
    );
  }
}
