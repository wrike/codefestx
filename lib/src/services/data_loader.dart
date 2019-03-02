import 'dart:convert';

import 'package:codefest/src/models/lecture_data.dart';
import 'package:codefest/src/models/lecture_type.dart';
import 'package:codefest/src/models/location.dart';
import 'package:codefest/src/models/speaker.dart';
import 'package:http/http.dart';

class DataLoader {
  static final _speakersPath = 'speakers';
  static final _locationsPath = 'locations';

  final Client _http;

  DataLoader(this._http);

  dynamic _extractData(Response resp) => json.decode(resp.body)['data'];

  Future<Iterable<Speaker>> getSpeakers() async {
    final response = await _http.get(_speakersPath);
    return (_extractData(response) as List).map((json) => Speaker.fromJson(json)).toList();
  }

  Future<Iterable<Location>> getLocations() async {
    final response = await _http.get(_locationsPath);
    print(response.body);
    print(json.decode(response.body));
    return (_extractData(response) as List).map((json) => Location.fromJson(json)).toList();
  }

  Iterable<LectureData> getLectures() => [
        LectureData(
          id: 'moneyball',
          title: 'Moneyball. Как построить команду продактов, когда на рынке их нет',
          type: LectureType.lecture,
          locationId: 'zal_2',
          speakerIds: ['evgen_chereshnev'],
          description:
              'Хорошие, опытные продакты — явление редкое. Обычно они уже работают в крутых компаниях, стоят очень дорого и не хотят менять работу. Учитывая хайп продактов в последние годы, задача их поиска ещё усложняется. В докладе я расскажу о том, как построить команду, нанимая людей из смежных профессий, как развивать у них продуктовые скиллы и как построить процессы, чтобы добиваться крутых результатов, развиваться персонально и расти всей командой.',
          duration: 45,
          startTime: DateTime(2019, 3, 30, 11, 45, 0),
        ),
        LectureData(
          id: 'safe_tests',
          title: 'Превращаем автотесты в тесты безопасности',
          type: LectureType.custom,
          locationId: 'angar_a',
          speakerIds: ['fedor_ovchinnikov'],
          description:
              'Поиск уязвимостей начинается с анализа функционала, сбора всех параметров и изучения бизнес-логики приложения. Чаще всего в автотестах это всё уже есть, осталось лишь сконвертировать их в тесты безопасности и подать нужные данные на вход. В докладе мы рассмотрим несколько примеров как это сделать и как найти уязвимости в своём проекте.',
          duration: 60,
          startTime: DateTime(2019, 3, 30, 12, 30, 0),
        ),
      ];
}
