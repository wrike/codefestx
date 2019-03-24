import 'package:codefest/src/models/release.dart';

class ReleasesFactory {
  static List<Release> get all => [
        Release(
          version: '1.0.0',
          author: 'Wrike dream team',
          avatar: 'https://cdn6.aptoide.com/imgs/3/6/7/367308a7915991b406a493b255f82323_icon.png?w=240',
          title: 'Расписание для CodeFest X',
          description: '<h3>Что мы приготовили:</h3>'
              '<ul>'
              '<li>Программа Codefest X адаптированная под мобылки.</li>'
              '<li>События вне основной программы: партнерские активности, стихийные лекции и воркшопы.</li>'
              '<li>Возможность создать своё расписание. Мы напомним об изранных событиях, чтобы вы не пропустили их.</li>'
              '<li>Лайки для интересных докладов, лучшие из которых уостоятся подарков от Wrike.</li>'
              '</ul>',
        ),
      ];
}