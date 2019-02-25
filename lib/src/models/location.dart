import 'package:meta/meta.dart';

class Location {
  final String id;
  final String title;
  final String logoPath;

  Location({
    @required this.id,
    @required this.title,
    this.logoPath,
  });
}
