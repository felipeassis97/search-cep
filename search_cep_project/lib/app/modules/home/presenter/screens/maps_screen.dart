import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_cep_project/app/theme/custom_app_bar.dart';

import '../stores/home_store.dart';

class MapsScreen extends StatefulWidget {
  final String place;
  const MapsScreen({Key? key, required this.place}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MapsScreenState();
}

class MapsScreenState extends State<MapsScreen> {
  final HomeStore store = Modular.get();

  static const _initialPosition = CameraPosition(
      target: LatLng(-30.066811361744058, -51.16391569019142), zoom: 11.5);

  GoogleMapController? _googleMapController;
  late double lat;
  late double lng;
  Marker? origin;
  Marker? destination;

//-30.066811361744058, -51.16391569019142

  @override
  void initState() {
    lat = store.latitude;
    lng = store.longitude;

    addMarker(LatLng(lat, lng));

    //store.getUserPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.place,
        centerTitle: true,
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition:
            CameraPosition(target: LatLng(lat, lng), zoom: 18.5),
        onMapCreated: (controller) => _googleMapController = controller,
        markers: {if (origin != null) origin!},
        onLongPress: addMarker,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        onPressed: () async {
          _googleMapController!
              .animateCamera(CameraUpdate.newCameraPosition(_initialPosition));

          await store.getUserPosition();
        },
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void addMarker(LatLng position) {
    setState(() {
      origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          position: position);
    });
  }

  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }
}
