import 'dart:io';

import 'package:uuid/uuid.dart';

class Place {
  Place(this.name, this.picture) : id = const Uuid().v4();

  final String name;
  final String id;
  final File picture;
}
