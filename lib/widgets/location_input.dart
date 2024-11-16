import 'dart:convert';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onLocationPicked});

  final void Function(PlaceLocation userLocation) onLocationPicked;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  var _gettingLocation = false;
  PlaceLocation? _pickedLocation;
  final mapsAPIKey = dotenv.env['API_KEY'];

  String get locationImageUrl {
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$lng&key=$mapsAPIKey';
  }

  void _savePlace(double lat, double lng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$mapsAPIKey');
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    final address = responseData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation =
          PlaceLocation(latitude: lat, longitude: lng, address: address);
      _gettingLocation = false;
    });
    widget.onLocationPicked(_pickedLocation!);
  }

  void _chooseOnMap() async {
    final pickedLocation = await Navigator.of(context)
        .push<LatLng>(MaterialPageRoute(builder: (ctx) => MapScreen()));

    if (pickedLocation != null) {
      _savePlace(pickedLocation.latitude, pickedLocation.longitude);
    }
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _gettingLocation = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;
    if (lat == null || lng == null) {
      return;
      //TODO Fehleranzeige, auch für HTTP request
    }
    _savePlace(lat, lng);
  }

  Widget get _content {
    return _pickedLocation == null
        ? Center(
            child: _gettingLocation
                ? const CircularProgressIndicator()
                : Text(
                    'No location chosen',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
          )
        : Image.network(
            locationImageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
            ),
            color: Colors.white10,
          ),
          child: _content,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              label: const Text('Get Current Location'),
              icon: Icon(Icons.location_on_outlined),
            ),
            TextButton.icon(
              onPressed: _chooseOnMap,
              label: const Text('Select on Map'),
              icon: Icon(Icons.map_outlined),
            ),
          ],
        ),
      ],
    );
  }
}
