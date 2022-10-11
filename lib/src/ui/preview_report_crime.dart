import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socialpolice/src/model/account.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/ui/components/header.dart';
import 'package:socialpolice/src/ui/components/two_row_text.dart';

class PreviewReportCrime extends StatefulWidget {
  String incidentType;
  String desc;
  File img;
  final Account? account;
  final String? serviceType;
  PreviewReportCrime({
    Key? key,
    required this.incidentType,
    required this.desc,
    required this.img,
    this.account,
    this.serviceType,
  }) : super(key: key);

  @override
  State<PreviewReportCrime> createState() => _PreviewReportCrimeState();
}

class _PreviewReportCrimeState extends State<PreviewReportCrime> {
  late TextEditingController _controller;

  late GoogleMapController _googleMapController;
  late Position position;
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(51.5074248, -0.1359362), zoom: 14);
  Set<Marker> markers = {};
  bool _isLoading = false;
  // final FirebaseStorageDataProvider _imageStorage =
  //     FirebaseStorageDataProvider();

  ValueNotifier<double>? _imageUploadProgress;
  // uploadImage() async {
  //   _imageUploadProgress = ValueNotifier(0);
  //   _imageStorage.uploadImage([widget.img], isIncident: true,
  //       progress: (int sent, int total) {
  //     _imageUploadProgress?.value = sent / total;
  //   });
  //   return [""];
  // }

  @override
  void initState() async {
    super.initState();
    _controller = TextEditingController(text: widget.desc);

    position = await _determinPosition();

    _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 14)));
    markers.clear();

    markers.add(Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(position.latitude, position.longitude)));

    setState(() {});
  }

  Future<Position> _determinPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location Service are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
        child: Column(
          children: [
            Header(
              title: 'Report Crime',
              actionTitle: 'Post',
              action: () {
                setState(() {
                  _isLoading = true;
                });
                // uploadImage();
              },
            ),
            const Divider(thickness: 1),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 180,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      width: MediaQuery.of(context).size.width,
                      child: Image.file(
                        widget.img,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Incident Type',
                        style: GoogleFonts.redHatDisplay(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      color: AppColors.colorBorderGrey4,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(widget.incidentType),
                        ),
                      ),
                    ),
                    const TwoRowText(
                      leftTitle: 'Description',
                      rightTitle: '600/1200',
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: const BoxDecoration(
                        color: AppColors.colorBorderGrey4,
                      ),
                      child: TextFormField(
                        controller: _controller,
                        maxLines: null,
                        minLines: 6,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8),
                        ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text('Location'),
                    ),
                    Container(
                      height: 194,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: GoogleMap(
                        initialCameraPosition: initialCameraPosition,
                        markers: markers,
                        zoomControlsEnabled: false,
                        mapType: MapType.normal,
                        onMapCreated: (GoogleMapController controller) {
                          _googleMapController = controller;
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
