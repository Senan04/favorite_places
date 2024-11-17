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
  ConsumerState<Places> createState() => _PlacesState();
}

class _PlacesState extends ConsumerState<Places> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(placesProvider.notifier).loadPlaces();
  }

  void _addItem() async {
    final placeDetails = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const AddPlace()));
    if (placeDetails != null) {
      ref.read(placesProvider.notifier).addPlace(placeDetails['name'],
          placeDetails['picture'], placeDetails['placeLocation']);
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
          leading: CircleAvatar(
            backgroundImage: FileImage(favoritePlaces[index].picture),
            radius: 30,
          ),
          title: Text(
            favoritePlaces[index].name,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          subtitle: Text(
            favoritePlaces[index].placeLocation.address,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
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
      body: FutureBuilder(
        future: _placesFuture,
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : _content,
      ),
    );
  }
}
