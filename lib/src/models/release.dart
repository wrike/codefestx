import 'package:meta/meta.dart';

class Release {
  final String version;
  final String title;
  final String description;
  final String avatar;
  final String author;
  final String company;

  Release({
    @required this.version,
    @required this.title,
    @required this.description,
    @required this.author,
    this.company,
    this.avatar = 'https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png',
  });
}
