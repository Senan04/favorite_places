import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(const []);

  void addPlace(Place place) {
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
