import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  LatLng? _selectedLocation;
  String? _ville;
  String? _quartier;
  bool _isMapReady = false;

  // Function to fetch city and area names
  Future<void> _getLocationDetails(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placemarks.isNotEmpty) {
        setState(() {
          _ville = placemarks.first.locality ?? "Unknown City";
          _quartier = placemarks.first.subLocality ?? "Unknown Area";
        });
      }
    } catch (e) {
      print("Error fetching location details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(33.87819, 10.87223),
              initialZoom: 12.0,
              onTap: (tapPosition, latlng) {
                setState(() {
                  _selectedLocation = latlng;
                });
                _getLocationDetails(latlng);
              },
              onMapReady: () {
                setState(() {
                  _isMapReady = true;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  if (_selectedLocation != null)
                    Marker(
                      point: _selectedLocation!,
                      width: 40.0,
                      height: 40.0,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                ],
              ),
            ],
          ),

          // Display Selected Location Details
          if (_selectedLocation != null)
            Positioned(
              bottom: 150,
              left: 20,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Latitude: ${_selectedLocation!.latitude}",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Longitude: ${_selectedLocation!.longitude}",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Ville: ${_ville ?? 'Fetching...'}"),
                    Text("Quartier: ${_quartier ?? 'Fetching...'}"),
                  ],
                ),
              ),
            ),

          // Zoom Controls
          Positioned(
            bottom: 80,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "zoom_in",
                  onPressed: () {
                    _mapController.move(
                      _mapController.camera.center,
                      _mapController.camera.zoom + 1,
                    );
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "zoom_out",
                  onPressed: () {
                    _mapController.move(
                      _mapController.camera.center,
                      _mapController.camera.zoom - 1,
                    );
                  },
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),

          // Save Location Button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              heroTag: "save_location",
              onPressed: () {
                if (_selectedLocation != null) {
                  Navigator.pop(
                    context,
                    {
                      "latitude": _selectedLocation!.latitude,
                      "longitude": _selectedLocation!.longitude,
                      "ville": _ville,
                      "quartier": _quartier,
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a location first'),
                    ),
                  );
                }
              },
              child: const Icon(Icons.save),
            ),
          ),
        ],
      ),
    );
  }
}
