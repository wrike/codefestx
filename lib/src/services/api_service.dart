import 'dart:async';
import 'dart:convert';
import 'package:codefest/src/models/lecture_data.dart';
import 'package:codefest/src/models/location.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/models/speaker.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

class ApiService extends MockClient {
  static final _initialSpeakers = [
    {
      'id': 'dylan',
      'name': 'Dylan Beattie',
      'company': 'Skills Matter',
      'avatarPath': 'https://2019.codefest.ru/upload/members/photo_1550168204_200.jpg',
      'description':
          'Dylan wrote his first web page in 1992 and never looked back. He’s been building data-driven web applications since the late 1990s, and has worked on everything from tiny standalone websites to complex distributed systems. He’s the CTO at Skills Matter in London, he’s a Microsoft MVP, and he’s a regular speaker at conferences and user groups, where he’s spoken about topics from continuous delivery and Conway’s Law to the history of the web, federated authentication and hypermedia APIs. When he’s not wrangling code, Dylan plays guitar and writes songs about code. He’s online at dylanbeattie.net and on Twitter as @dylanbeattie.',
    },
    {
      'id': 'evgen',
      'name': 'Евгений Черешнёв',
      'company': 'Biolink.Tech',
      'avatarPath': 'https://2019.codefest.ru/upload/members/photo_1548787955_200.jpg',
      'description':
          'Юрист по образованию, IT-исследователь по призванию. Евгений с детства любил компьютеры. В 1988 он впервые сел за клавиатуру и написал свою первую программу. После окончания ВУЗа, стал одним из ведущих IT-журналистов России, прошел путь от внештатного автора журнала «Хакер» до Главного редактора «КоммерсантЪ-IT». Опубликовал более 1000 статей по hardware, software, искусственному интеллекту. В 2006 переключился на бизнес: сначала в роли издателя «КоммерсантЪ IT&Telecom», а в 2009м открыл свою первую международную компанию, клиентами которой стали такие бренды, как Nokia, Microsoft, Acer и многие другие. В начале 2012, на одном из мероприятий «Лаборатории Касперского» Черешнев получил предложение влиться в команду лаборатории. Евгений продал свою компанию и присоединился к команде Kasperksy Lab (Оборот 680 млн. USD/год), где занимал позиции директора по развитию мобильного бизнеса и вице-президента по международному маркетингу. Плотная многолетняя работа с ведущими экспертами по кибербезопасности из России, США, Японии, Германии, Франции, Великобритании, Сингапура и Латинской Америки и проект BionicMan, в рамках которого Евгений вживил под кожу своей левой руки биочип для исследования вопросов приватности человека в мире «интернета вещей», привели эксперта к созданию запатентованной технологии «Цифрового ДНК». Данная инновация, по мнению Черешнева, может совершить революцию в «Интернете вещей», позволяя человеку управлять многочисленными устройствами без нужды в авторизации и сложных паролях. Тема была признана важной международным сообществом — в феврале 2017-го Евгений Черешнев стал первым в мире российским спикером-представителем ИТ-индустрии, приглашенным на ведущую конференцию по вопросам инноваций TED New York.',
    },
    {
      'id': 'fedya',
      'name': 'Фёдор Овчинников',
      'company': 'Додо Пицца',
      'avatarPath': 'https://2019.codefest.ru/upload/members/photo_1548090045_200.jpg',
      'description':
          'Основатель и руководитель компании «Додо Пицца». По образованию археолог, окончил Сыктывкарский Государственный Университет. В 2011 году открыл в Сыктывкаре первую пиццерию «Додо Пицца». В 2014 году «Додо Пицца» осуществила первую в мире коммерческую доставку с помощью дронов. А в 2015 году привлекла 106 миллионов рублей от частных инвесторов — это самый крупный кейс в истории российского краудинвестинга. Высокие темпы роста сети обеспечивает франчайзинг и инновационная бизнес-модель. Она основана на облачной информационной системе «Додо ИС». Эта система управляет всем бизнесом и повышает эффективность как каждой отдельной пиццерии, так и всей сети в целом. По итогам 2017 года компания «Додо Пицца» стала крупнейшей сетью в России и Казахстане по количеству пиццерий. Сегодня сеть насчитывает более 400 пиццерии в 11 странах, включая США, Англию и Китай. Основа бизнеса Додо — полная прозрачность и открытость, а также собственная облачная информационная система «Додо ИС», которая управляет всем бизнесом.',
    },
    {
      'id': 'orlov',
      'name': 'Александр Орлов',
      'company': 'Стратоплан',
      'avatarPath': 'https://2019.codefest.ru/upload/members/photo_1548955107_200.jpg',
      'description':
          'Управляющий партнер группы проектов Стратоплан. В прошлом менеджер в компаниях Intel и Sun. Тренер Школы менеджеров Стратоплан по работе с людьми и управленческим навыкам. Лично разобрал более 1000 управленческих кейсов. Совместно со Славой Панкратовым автор более 100 образовательных программ Стратоплана, через которые прошли более 15 000 менеджеров ведущих компаний. Автор книг «Секреты управления программистами», «Белая книжная полка менеджера», «Джедайские техники конструктивного общения».',
    },
    {
      'id': 'sashka',
      'name': 'Александр Баяндин',
      'company': 'Badoo',
      'avatarPath': 'https://2019.codefest.ru/upload/members/photo_1549091913_200.jpg',
      'description':
          'Занимается автоматизацией тестирования в Badoo. Ранее работал в 2GIS и Mail.ru, 2 семестра вёл курс в Технопарк@Mail.ru по обеспечению качества в разработке. Коммитил в Selenium и Appium. Не менеджер, не консультант и не тренер. Пишет на Python и Ruby. А ещё у него есть репозиторий на GitHub с более чем 23 тысячами звёздочек.',
    },
  ];
  static final _initialLocations = [
    {
      'id': 'steklo2',
      'title': 'Стекляшка 2',
      'logoPath': 'https://2019.codefest.ru/assets/frontend/2019/dist/assets/icons/24/pin.svg',
      'mapPath': 'https://i.gyazo.com/74bf7b7454fb8c34d3d4ad127c727894.png',
      'description': 'Стекляшка',
    },
    {
      'id': 'zal3',
      'title': 'Зал №3',
      'logoPath': 'https://2019.codefest.ru/assets/frontend/2019/dist/assets/icons/24/pin.svg',
      'mapPath': 'https://i.gyazo.com/74bf7b7454fb8c34d3d4ad127c727894.png',
      'description': 'Зал',
    },
    {
      'id': 'angar_a',
      'title': 'Ангар А',
      'logoPath': 'https://2019.codefest.ru/assets/frontend/2019/dist/assets/icons/24/pin.svg',
      'mapPath': 'https://i.gyazo.com/74bf7b7454fb8c34d3d4ad127c727894.png',
      'description': 'Ангар',
    },
  ];
  static final _initialSections = [
    {
      'id': 'be',
      'title': 'Backend',
      'iconPath': 'https://cdn.pixabay.com/photo/2014/08/22/02/10/be-423796_640.png',
      'color': '#ff0000',
      'description': 'В этому году в Бэкенде — баланс между суровым хардкором и практическими темами, которые вы сможете использовать на работе уже в понедельник после CodeFest. Для Java разработчиков — доклады про нюансы работы JVM, модные фреймворки, а также про быстро набирающий популярность Kotlin. .NET разработчики найдут интересные доклады про архитектуру, хардкор с дебагом через WinDBG и функциональщину на F#. Не забыли и про другие платформы / языки — в программе крутые доклады по Scala, Python, C++, Go и Postgres.',
    },
    {
      'id': 'ds',
      'title': 'Data Science',
      'iconPath': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYu9iTC6ZFpG_kF1yvt4bGWZOZaOPGDpI9cvPHflKV1uVP130w',
      'color': '#00ff00',
      'description': 'Магия и технология машинного обучения во всех своих проявлениях — вот чему будет посвящена секция «Data Science». Расширить реальность с помощью нейросетей? Без проблем! Научить компьютер непринуждённой беседе? Пожалуйста! Это и многое другое не в научной фантастике, а уже на проде и в опен-сорсе! Хотите узнать, как? Приходите к нам на секцию! PS Ничего уникального, но на Хабре — вдруг комментарий оставить захотите.',
    },
  ];
  static final _initialLectures = [
    {
      'id': 'fichi',
      'title': 'Продуктовые фичи: война бесконечности',
      'type': 'lecture',
      'speakerIds': ['orlov'],
      'description': 'Мы работаем над сообщениями ВКонтакте. В противостоянии с мессенджерами ни в коем случае нельзя отставать, приходится одновременно брать в работу фичи из самых разных направлений. При этом есть ещё баги, техдолг, а окружающий мир всегда пытается подставить подножку планам. Расскажу о том, как мы наводим во всём этом порядок и продолжаем двигаться вперёд.',
      'locationId': 'angar_a',
      'sectionId': 'be',
      'startTime': DateTime(2019, 3, 30, 10, 0, 0).toString(),
      'duration': 80,
    },
    {
      'id': 'doctor',
      'title': 'Доктор сказал «в морг», значит — в морг!',
      'type': 'lecture',
      'speakerIds': ['sashka', 'fedya'],
      'description': 'За три последних года в Контуре произошло примерно 1000 факапов разной степени эпичности. Среди них, например, 36% были вызваны выкатыванием некачественного релиза в продакшен, а 14% — работами по обслуживанию железа в дата-центре. Откуда я все это знаю? Из архива отчетов, которые мы называем постмортемами. Постмортемы пишут дежурные инженеры, которые отреагировали на уведомление об аварии и первыми начали разбираться в её причинах. Зачем нашей команде этот архив? Зачем мы заставляем инженера, который несколько часов без сна чинил сложную систему, ещё и написать несколько страниц текста об этом? Эти знания помогают нам двигать инфраструктурную разработку в правильном направлении. Чем нужно заняться прямо сейчас — улучшать систему сбора метрик или отбирать у разработчиков админские права на серверах? От чего будет больше пользы— нового инструмента для нагрузочного тестирования или внедрения канареечного деплоя? В докладе я расскажу о том, как написать полезный постмортем: кто должен его писать, что обязательно нужно упомянуть и как внедрять эту сложную DevOps-практику в большой компании, где еще несколько лет назад никто ни о каких постмортемах даже не слышал. Разберём пару примеров настоящих факапов — признайтесь, вы же любите слушать истории о том, как кто-то облажался :)',
      'locationId': 'zal3',
      'sectionId': 'ds',
      'startTime': DateTime(2019, 3, 30, 12, 0, 0).toString(),
      'duration': 90,
    },
    {
      'id': 'go',
      'title': 'Инструментирование Go кода',
      'type': 'custom',
      'speakerIds': ['evgen'],
      'description': 'В то время как язык Go предоставляет нам много таких крутых инструментов как go-рутины, каналы, утиная типизация, быстрый сборщик мусора, маленький рантайм и компиляцию в нативный код под множество платформ, мы, как разработчики, часто страдаем от того, что нам нужно платить дань в виде рутинного, повторяющегося кода. В своём докладе я продемонстрирую, что несмотря на расхожее мнение, отсутствие дженериков это далеко не основная проблема Go, с которой мы сталкиваемся каждый день на практике. Мы поговорим о применимости и применении такого шаблона проектирования как «декоратор» для инструментирования Go кода. На примерах из реальной жизни, я покажу, каким образом можно решить типовые инженерные проблемы с помощью одного простого инструмента. Вы узнаете, как можно победить рутину и добавить такую функциональность как метрики, трейсинг, повторы, предохранители, логгирование и другую функциональность в ваши проекты на Go за считанные секунды!',
      'locationId': 'steklo2',
      'sectionId': 'ds',
      'startTime': DateTime(2019, 3, 31, 10, 0, 0).toString(),
      'duration': 30,
    },
    {
      'id': 'tcp',
      'title': 'TCP умер или будущее сетевых протоколов',
      'type': 'lecture',
      'speakerIds': ['dylan'],
      'description': 'В докладе мы поговорим про эволюцию и настройки сетевого стека TCP/IP в linux и Android, iOS в контексте мобильных сетей, разберем проблемы TCP в плохих сетях, я поделюсь опытом ОК в написании своих сетевых протоколов в user space поверх UDP. Также рассмотрим развитие QUIC и проблемы UDP и User Space протоклов. TCP был впервые имплементирован в 70-х годах и прекрасно справлялся со своей задачей в эру проводного интернета. Но беспроводные сети отличаются переменной пропускной способностью, высоким packet loss, сменой IP и MTU на лету и прочими вещами, которые приводят к деградации TCP-соединения. В социальной сети «Одноклассники» более 30 млн человек ежедневно заходят используя мобильные сети. Средний packet loss в этих сетях порядка 1-3%, но бывают сети и с потерями до 10-15%. Кроме этого в мобильных сетях высокие значения jitter-а и RTT. Это всё приводит к тому, что канал утилизируется не полностью, а передача данных работает медленнее, чем могла бы. Мы поговорим про проблемы TCP, его tuning. Рассмотрим эволюцию TCP стека для ускорения передачи данных от cubic congestion control до BBR cc, а так же tail loss probe, tcp fast open, zeroRTT handshake в TLS 1.3, как это настроить и как это работает ;) Но многие улучшения TCP не достаточно быстро оказывается в продакшене как на серверах, так и на конечных устройствах пользователей. Поэтому мы рассмотрим дальнейшее развитие сетевого стека в сторону userSpace протоколов типа QUIC. И расскажу про экспертизу OK.ru в реализации собственных протоколов передачи данных поверх UDP.',
      'locationId': 'zal3',
      'sectionId': 'be',
      'startTime': DateTime(2019, 3, 30, 14, 30, 0).toString(),
      'duration': 45,
    },
  ];
  static List<Speaker> _speakerDb;
  static List<Location> _locationDb;
  static List<LectureData> _lecturesDb;
  static List<Section> _sectionsDb;

  static Future<Response> _handler(Request request) async {
    if (_speakerDb == null) resetDb();
    Iterable<Object> data;

    switch (request.url.pathSegments.last) {
      case 'locations':
        data = _locationDb;
        break;
      case 'sections':
        data = _sectionsDb;
        break;
      case 'speakers':
        data = _speakerDb;
        break;
      case 'lectures':
        data = _lecturesDb;
        break;
    }
    return Response(json.encode(data), 200, headers: {'content-type': 'application/json; charset=utf-8'});
  }

  static void resetDb() {
    _speakerDb = _initialSpeakers.map((json) => Speaker.fromJson(json)).toList();
    _locationDb = _initialLocations.map((json) => Location.fromJson(json)).toList();
    _sectionsDb = _initialSections.map((json) => Section.fromJson(json)).toList();
    _lecturesDb = _initialLectures.map((json) => LectureData.fromJson(json)).toList();
  }

  ApiService() : super(_handler);
}
