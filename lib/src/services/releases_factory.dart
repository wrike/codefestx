import 'package:codefest/src/models/release.dart';

const WRIKE_AVATAR = 'https://i.ibb.co/y6Fz3vM/wrike.png';
const WRIKE_AUTHOR = 'Wrike dream team';

class ReleasesFactory {
  static List<Release> get all => [
        Release(
          version: '1.0.0',
          author: WRIKE_AUTHOR,
          avatar: WRIKE_AVATAR,
          title: 'MVP расписания для CodeFest X',
          description: '<h3>Что мы приготовили:</h3>'
              '<ul>'
              '<li>Программа Codefest X, адаптированная под мобилки.</li>'
              '<li>События вне основной программы: партнерские активности, стихийные лекции и воркшопы.</li>'
              '<li>Возможность создать своё расписание. Мы напомним об избранных событиях, чтобы вы не пропустили их.</li>'
              '<li>Лайки для интересных докладов, лучшие из которых мы наградим.</li>'
              '</ul>',
        ),
      ];
}
