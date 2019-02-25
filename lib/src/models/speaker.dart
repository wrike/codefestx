import 'package:meta/meta.dart';

class Speaker {
  final String id;
  final String name;
  final String company;
  final String avatarPath;
  final String description;

  Speaker({
    @required this.id,
    @required this.name,
    this.company,
    @required this.avatarPath,
    @required this.description,
  });
}
