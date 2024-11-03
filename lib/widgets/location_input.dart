import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
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
          child: Center(
            child: Text(
              'No location chosen',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {},
              label: const Text('Get Current Location'),
              icon: Icon(Icons.location_on_outlined),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text('Select on Map'),
              icon: Icon(Icons.map_outlined),
            ),
          ],
        ),
      ],
    );
  }
}
