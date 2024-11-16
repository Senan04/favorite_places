import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(const []);

  void addPlace(Place place) async {
    final appDocumentsDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(place.picture.path);
    place.picture =
        await place.picture.copy('${appDocumentsDir.path}/$filename');
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
