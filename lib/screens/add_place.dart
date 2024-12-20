import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({super.key});

  @override
  State<AddPlace> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlace> {
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle = '';
  File? _takenPicture;
  PlaceLocation? _userLocation;

  void _saveItem() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    //TODO: show error to user instead of just returning
    if (_takenPicture == null || _userLocation == null) return;
    Navigator.of(context).pop({
      'name': _enteredTitle,
      'picture': _takenPicture!,
      'placeLocation': _userLocation!
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Place'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1) {
                      return 'Must be between 2 and 50 characters';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _enteredTitle = newValue!,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ImageInput(
                onPictureTaken: (takenPicture) {
                  _takenPicture = takenPicture;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              LocationInput(
                onLocationPicked: (userLocation) {
                  _userLocation = userLocation;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton.icon(
                onPressed: _saveItem,
                label: const Text('Add Place'),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
