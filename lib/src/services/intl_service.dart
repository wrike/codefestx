import 'package:intl/intl.dart';

class IntlService {
  static String ruLang = 'ru_RU';
  static String enLang = 'en_US';

  /// Empty States
  static String ratingEmptyTitle() => Intl.message(
        'No one voted yet',
        name: 'IntlService_ratingEmptyTitle',
        args: [],
        desc: 'No one voted yet',
      );

  static String ratingEmptyMessage() => Intl.message(
        'The rating will be shown here once someone votes',
        name: 'IntlService_ratingEmptyMessage',
        args: [],
        desc: 'The rating will be shown here once someone votes',
      );

  static String somethingWrongEmptyTitle() => Intl.message(
        'Ooops..',
        name: 'IntlService_somethingWrongEmptyTitle',
        args: [],
        desc: 'Ooops..',
      );

  static String somethingWrongEmptyMessage() => Intl.message(
        'Something went wrong :( Please tell us more',
        name: 'IntlService_somethingWrongEmptyMessage',
        args: [],
        desc: 'No one voted yet',
      );

  static String pageNotFoundEmptyTitle() => Intl.message(
        'Whoops!',
        name: 'IntlService_pageNotFoundEmptyTitle',
        args: [],
        desc: 'Whoops!',
      );

  static String pageNotFoundEmptyMessage() => Intl.message(
        '404 - Page not found',
        name: 'IntlService_pageNotFoundEmptyMessage',
        args: [],
        desc: '404 - Page not found',
      );

  static String talksEmptyTitle() => Intl.message(
        'Anything to say?',
        name: 'IntlService_talksEmptyTitle',
        args: [],
        desc: 'Anything to say?',
      );

  static String talksEmptyMessage() => Intl.message(
        'Ask questions, leave your comments or give a big round of applause to your favorite speaker.',
        name: 'IntlService_talksEmptyMessage',
        args: [],
        desc: 'Ask questions, leave your comments or give a big round of applause to your favorite speaker.',
      );

  static String favoriteEmptyTitle() => Intl.message(
        'Nothing yet',
        name: 'IntlService_favoriteEmptyTitle',
        args: [],
        desc: 'Nothing yet',
      );

  static String favoriteEmptyMessage() => Intl.message(
        'Add the talks to your favourites and they will appear here',
        name: 'IntlService_favoriteEmptyMessage',
        args: [],
        desc: 'Add the talks to your favourites and they will appear here',
      );

  static String currentTalksEmptyTitle() => Intl.message(
        'Nothing is happening now',
        name: 'IntlService_currentTalksEmptyTitle',
        args: [],
        desc: 'Nothing is happening now',
      );

  static String currentTalksEmptyMessage() => Intl.message(
        'Come back here when the talk is live',
        name: 'IntlService_currentTalksEmptyMessage',
        args: [],
        desc: 'Come back here when the talk is live',
      );

  static String searchEmptyTitle() => Intl.message(
        'No results',
        name: 'IntlService_searchEmptyTitle',
        args: [],
        desc: 'No results',
      );

  static String searchEmptyMessage() => Intl.message(
        'Try searching for something else',
        name: 'IntlService_searchEmptyMessage',
        args: [],
        desc: 'Try searching for something else',
      );

  /// Buttons
  static String goToScheduleButton() => Intl.message(
        'Go to schedule',
        name: 'IntlService_goToScheduleButton',
        args: [],
        desc: 'Go to schedule',
      );
}
