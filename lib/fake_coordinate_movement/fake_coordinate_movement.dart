import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class FakeCoordinateMovement extends StatefulWidget {
  const FakeCoordinateMovement({super.key});

  @override
  State<FakeCoordinateMovement> createState() => _FakeCoordinateMovementState();
}

class _FakeCoordinateMovementState extends State<FakeCoordinateMovement> {
  MapController mapController = MapController();
  LatLng currentLocation = LatLng(37.7749, -122.4194);

  void updateLocation(LatLng newLocation) {
    setState(() {
      currentLocation = newLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Simulator'),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: currentLocation,
          zoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 30.0,
                height: 30.0,
                point: currentLocation,
                builder: (context) => Container(
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final random = Random();
          final newLocation = LatLng(
              currentLocation.latitude + (random.nextDouble() - 0.5) * 0.01,
              currentLocation.longitude + (random.nextDouble() - 0.5) * 0.01);
              updateLocation(newLocation);
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
