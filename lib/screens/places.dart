import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Places extends ConsumerStatefulWidget {
  const Places({super.key});

  @override
  ConsumerState<Places> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<Places> {
  void _addItem() async {
    final addedPlace = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const AddPlace()));
    if (addedPlace != null) {
      ref.read(placesProvider.notifier).addPlace(addedPlace);
    }
  }

  void _showDetails(Place place) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => PlaceDetails(place: place)));
  }

  void _removeItem(int index) {
    ref.read(placesProvider.notifier).removePlaceAt(index);
  }

  Widget get _content {
    final favoritePlaces = ref.watch(placesProvider);
    if (favoritePlaces.isEmpty) {
      return const Center(
          child: Text('You do not have any favorite places yet!'));
    }
    return ListView.builder(
      itemCount: favoritePlaces.length,
      itemBuilder: (ctx, index) => Slidable(
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              onPressed: (ctx) => _removeItem(index),
              icon: Icons.delete,
              label: 'Delete',
            )
          ],
        ),
        child: ListTile(
          title: Text(favoritePlaces[index].name),
          onTap: () => {_showDetails(favoritePlaces[index])},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
      body: _content,
    );
  }
}
