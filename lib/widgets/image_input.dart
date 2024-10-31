import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<StatefulWidget> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  var pictureAdded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
        ),
        color: Colors.white10,
      ),
      child: SizedBox(
        height: 250,
        width: double.infinity,
        child: Center(
          child: pictureAdded
              ? const Placeholder()
              : TextButton.icon(
                  onPressed: () {},
                  label: const Text('Add a picture'),
                  icon: const Icon(Icons.camera),
                ),
        ),
      ),
    );
  }
}
