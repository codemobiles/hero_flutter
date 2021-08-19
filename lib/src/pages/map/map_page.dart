import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_flutter/src/constants/asset.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initMap = CameraPosition(
    target: LatLng(13.7465354, 100.532752),
    zoom: 12,
  );

  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: _initMap,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _dummyLocation();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: null,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _dummyLocation() async {
    await Future.delayed(Duration(seconds: 2));
    List<LatLng> data = [
      LatLng(13.7330609, 100.5290547),
      LatLng(13.7304786, 100.5322757),
      LatLng(13.7286446, 100.5326617),
      LatLng(13.731132, 100.523406),
      LatLng(13.734506, 100.519914),
      LatLng(13.737904, 100.521985),
      LatLng(13.724373, 100.524751),
    ];

    for (var latLng in data) {
      await _addMarker(
        latLng,
        title: 'Rider009',
        snippet: 'Cat Lover',
      );
    }

    _controller.future.then((controller) => controller.moveCamera(
        CameraUpdate.newLatLngBounds(_boundsFromLatLngList(data), 32)));
    setState(() {});
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1 = 0;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }

  Future<Uint8List> _getBytesFromAsset(
    String path, {
    required int width,
  }) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> _addMarker(
    LatLng position, {
    String title = 'none',
    String snippet = 'none',
    String pinAsset = Asset.pinBikerImage,
    bool isShowInfo = false,
  }) async {
    final Uint8List markerIcon = await _getBytesFromAsset(
      pinAsset,
      width: 150,
    );
    final BitmapDescriptor bitmap = BitmapDescriptor.fromBytes(markerIcon);

    _markers.add(
      Marker(
        // important. unique id
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: isShowInfo
            ? InfoWindow(
                title: title,
                snippet: snippet,
                onTap: () => _launchMaps(
                  lat: position.latitude,
                  lng: position.longitude,
                ),
              )
            : InfoWindow(),
        icon: bitmap,
        onTap: () async {
          //todo
        },
      ),
    );
  }

  void _launchMaps({required double lat, required double lng}) {}
}
