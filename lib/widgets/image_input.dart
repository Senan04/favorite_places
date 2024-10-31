import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<StatefulWidget> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
        ),
        color: Colors.white10,
      ),
      child: const SizedBox(
        height: 250,
        width: double.infinity,
        child: Center(
          child: Text('TEST'),
        ),
      ),
    );
  }
}
