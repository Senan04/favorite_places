import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
//import 'package:sqflite/sqlite_api.dart';

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(const []);

  void addPlace(String title, File takenPicture, PlaceLocation location) async {
    final appDocumentsDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(takenPicture.path);

    final picture =
        await takenPicture.copy('${appDocumentsDir.path}/$filename');
    final place = Place(name: title, picture: picture, placeLocation: location);

    final database = openDatabase(
      path.join(await getDatabasesPath(), 'places_database.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE places(id TEXT PRIMARY KEY, name TEXT, image TEXT, latitude REAL, longitude REAL, address TEXT)');
      },
      version: 1,
    );

    state = [...state, place];
  }

  void removePlaceAt(int index) {
    var stateCopy = List.of(state);
    stateCopy.removeAt(index);
    state = stateCopy;
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
    (ref) => PlacesNotifier());
