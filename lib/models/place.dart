import 'dart:io';

import 'package:uuid/uuid.dart';

class PlaceLocation {
  const PlaceLocation(
      {required this.latitude, required this.longitude, required this.address});

  final double latitude;
  final double longitude;
  final String address;
}

class Place {
  Place({
    required this.name,
    required this.picture,
    required this.placeLocation,
    String? id,
  }) : id = id ?? const Uuid().v4();

  final String name;
  final String id;
  File picture;
  final PlaceLocation placeLocation;

  Map<String, Object> toMap() {
    return {
      'id': id,
      'name': name,
      'image': picture.path,
      'latitude': placeLocation.latitude,
      'longitude': placeLocation.longitude,
      'address': placeLocation.address,
    };
  }
}
