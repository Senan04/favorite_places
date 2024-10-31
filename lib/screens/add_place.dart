import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({super.key});

  @override
  State<AddPlace> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlace> {
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle = '';

  void _saveItem() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    Navigator.of(context).pop(Place(_enteredTitle));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Place'),
      ),
      body: Form(
        key: _formKey,
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
            const ImageInput(),
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
    );
  }
}
