@JS('Pushwoosh')
library Pushwoosh;

import "package:js/js.dart";

@JS("push")
external String push(obj);

@JS()
@anonymous
class PushOptions {
  external String get logLevel;
  external String get applicationCode;
  external String get safariWebsitePushID;
  external String get defaultNotificationTitle;
  external String get defaultNotificationImage;
  external bool get autoSubscribe;
  external String get userId;

  external factory PushOptions({
    String logLevel,
    String applicationCode,
    String safariWebsitePushID,
    String defaultNotificationTitle,
    String defaultNotificationImage,
    bool autoSubscribe,
    String userId
  });
}


class PushService {
  void init(String userId) {
    print('PushService subscribe with $userId');

    final options = PushOptions(
        logLevel: 'info',
        applicationCode: '7DA94-50B16',
        safariWebsitePushID: 'web.codefest.wrike.tech',
        defaultNotificationTitle: 'CodeFest',
        defaultNotificationImage: 'https://2019.codefest.ru/assets/frontend/2019/dist/assets/img/logo--on-white.svg',
        autoSubscribe: true,
        userId: userId,
    );

    push(['init', options]);
  }
}
