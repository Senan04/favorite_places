import 'package:uuid/uuid.dart';

class Place {
  Place(this.name) : id = const Uuid().v4();

  String name;
  String id;
}
