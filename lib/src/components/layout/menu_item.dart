class MenuItem {
  static const lectures = const MenuItem._('Расписание', 'lectures');
  static const speakers = const MenuItem._('Спикеры', 'speakers');
  static const map = const MenuItem._('Карта', 'map');
  static const feedback = const MenuItem._('Отправить feedback', 'feedback');

  static const _values = [
    MenuItem.lectures,
    MenuItem.speakers,
    MenuItem.map,
    MenuItem.feedback,
  ];

  static List<MenuItem> get values => _values;

  final String title;

  final String key;

  const MenuItem._(this.title, this.key);

  static MenuItem get(String key) => _values.firstWhere((menu) => menu.key == key, orElse: () => null);
}
