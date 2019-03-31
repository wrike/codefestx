import 'package:codefest/src/models/release.dart';

const WRIKE_AVATAR = 'https://i.ibb.co/y6Fz3vM/wrike.png';
const WRIKE_AUTHOR = 'Wrike dream team';

class ReleasesFactory {
  static List<Release> get all => [
    Release(
      version: '1.2.0',
      author: WRIKE_AUTHOR,
      avatar: WRIKE_AVATAR,
      title: 'Обший рейтинг докладов',
      description: 
        'Добавили страницу с лучшими докладами на CodeFest по мнению посетителей конференции. '
        'Голосуйте за доклады, которые вам понравились, а Wrike наградит докладчика, '
        'набравшего наибольшее количество голосов!'
    ),
    Release(
      version: '1.1.0',
      author: WRIKE_AUTHOR,
      avatar: WRIKE_AVATAR,
      title: 'Обсуждения докладов для CodeFest X',
      description: 
        'Добавили возможность обсуждения докладов!'
        'Не смогли пообщаться со спикером в экспетной зоне - можете сделать это у нас.',
    ),
    Release(
      version: '1.0.1',
      author: 'Алексей Дорохов',
      avatar: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0UlCZ8gU8Pl4XeFVuYOVUyFWnvY3oc04UD2hkEx1TwmW5egBe',
      title: 'Индикатор популярности доклада',
      description: '<h3>Что мы приготовили:</h3>'
          '<ul>'
          '<li>Теперь в расписании есть индикатор популярности доклада.</li>'
          '</ul>',
    ),
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
