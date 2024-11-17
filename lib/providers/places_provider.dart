import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  return await sql.openDatabase(
    path.join(await sql.getDatabasesPath(), 'places_database.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE places(id TEXT PRIMARY KEY, name TEXT, image TEXT, latitude REAL, longitude REAL, address TEXT)');
    },
    version: 1,
  );
}

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(const []);

  void loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('places');
    final places = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            name: row['name'] as String,
            picture: File(row['image'] as String),
            placeLocation: PlaceLocation(
              latitude: row['latitude'] as double,
              longitude: row['longitude'] as double,
              address: row['address'] as String,
            ),
          ),
        )
        .toList();
    state = places;
  }

  void addPlace(String title, File takenPicture, PlaceLocation location) async {
    final appDocumentsDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(takenPicture.path);

    final picture =
        await takenPicture.copy('${appDocumentsDir.path}/$filename');
    final place = Place(name: title, picture: picture, placeLocation: location);

    final database = await _getDatabase();
    database.insert(
      'places',
      place.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
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
