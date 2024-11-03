import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPictureTaken});

  final void Function(File takenPicture) onPictureTaken;

  @override
  State<StatefulWidget> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  var pictureAdded = false;
  File? _takenPicture;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) return;

    _takenPicture = File(pickedImage.path);
    setState(() {
      pictureAdded = true;
    });
    widget.onPictureTaken(_takenPicture!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
        ),
        color: Colors.white10,
      ),
      child: Center(
        child: pictureAdded
            ? GestureDetector(
                onTap: _takePicture,
                child: Image.file(
                  _takenPicture!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              )
            : TextButton.icon(
                onPressed: _takePicture,
                label: const Text('Add a picture'),
                icon: const Icon(Icons.camera),
              ),
      ),
    );
  }
}
