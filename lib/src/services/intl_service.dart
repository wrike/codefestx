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

  /// Menu & Routes
  static String scheduleRoute() => Intl.message(
        'Schedule',
        name: 'IntlService_scheduleRoute',
        args: [],
        desc: 'Schedule',
      );

  static String ratingRoute() => Intl.message(
        'Rating',
        name: 'IntlService_ratingRoute',
        args: [],
        desc: 'Rating',
      );

  static String mapRoute() => Intl.message(
        'Map',
        name: 'IntlService_mapRoute',
        args: [],
        desc: 'Map',
      );

  /// Buttons
  static String goToScheduleButton() => Intl.message(
        'Go to schedule',
        name: 'IntlService_goToScheduleButton',
        args: [],
        desc: 'Go to schedule',
      );

  static String changeLanguageButton() => Intl.message(
        'Перейти на русский',
        name: 'IntlService_changeLanguageButton',
        args: [],
        desc: 'Switch to English',
      );

  /// Filters
  static String allFilter() => Intl.message(
        'All',
        name: 'IntlService_allFilter',
        args: [],
        desc: 'All',
      );

  static String favoritesFilter() => Intl.message(
        'Favorites',
        name: 'IntlService_favoritesFilter',
        args: [],
        desc: 'Favorites',
      );

  static String customEventsFilter() => Intl.message(
        'Events',
        name: 'IntlService_customEventsFilter',
        args: [],
        desc: 'Events',
      );

  static String liveFilter() => Intl.message(
        'Live',
        name: 'IntlService_liveFilter',
        args: [],
        desc: 'Live',
      );

  /// Talk card
  static String eventTitle() => Intl.message(
        'Event',
        name: 'IntlService_eventTitle',
        args: [],
        desc: 'Event',
      );

  static String talkTitle() => Intl.message(
        'Talk',
        name: 'IntlService_talkTitle',
        args: [],
        desc: 'Talk',
      );

  static String infoTabTitle() => Intl.message(
        'Info',
        name: 'IntlService_infoTabTitle',
        args: [],
        desc: 'Info',
      );

  static String discussionTabTitle() => Intl.message(
        'Discussion',
        name: 'IntlService_discussionTabTitle',
        args: [],
        desc: 'Discussion',
      );

  /// Voting
  static String votingMainTitle() => Intl.message(
        'Do you like the talk? Vote!',
        name: 'IntlService_votingMainTitle',
        args: [],
        desc: 'Do you like the talk? Vote!',
      );

  static String votingMainSubtitle() => Intl.message(
        'We will award the best speaker',
        name: 'IntlService_votingMainSubtitle',
        args: [],
        desc: 'We will award the best speaker',
      );

  static String voteButton() => Intl.message(
        'Vote',
        name: 'IntlService_voteButton',
        args: [],
        desc: 'Vote',
      );

  static String voteDoneButton() => Intl.message(
        'You voted',
        name: 'IntlService_voteDoneButton',
        args: [],
        desc: 'You voted',
      );

  static String votingNotice() => Intl.message(
        'Voting will be available 5 minutes after the talk starts',
        name: 'IntlService_votingNotice',
        args: [],
        desc: 'Voting will be available 5 minutes after the talk starts',
      );

  /// Discussion
  static String discussionPlaceholder() => Intl.message(
        'Write something...',
        name: 'IntlService_discussionPlaceholder',
        args: [],
        desc: 'Write something...',
      );

  static String replyButton() => Intl.message(
        'Reply',
        name: 'IntlService_replyButton',
        args: [],
        desc: 'Reply',
      );

  static String deleteButton() => Intl.message(
        'Delete',
        name: 'IntlService_deleteButton',
        args: [],
        desc: 'Delete',
      );
}
