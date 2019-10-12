import 'package:intl/intl.dart';

class IntlService {
  static String ruLang = 'ru_RU';
  static String enLang = 'en_US';

  static String ratingEmptyTitle() => Intl.message(
        'No one voted yet',
        name: 'IntlService_ratingEmptyTitle',
        args: [],
        desc: 'No one voted yet',
      );
}
