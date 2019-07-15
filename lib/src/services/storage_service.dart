import 'dart:convert';
import 'dart:html';

import 'package:codefest/src/models/_types.dart';

class StorageService {
  static const String _favoritesKey = 'favorites';
  static const String _sectionsKey = 'sections';
  static const String _languagesKey = 'languages';
  static const String _customSectionMode = 'customSectionMode';

  void addFavoriteLecture(String lectureId) => _addToList(_favoritesKey, lectureId);

  void clearSectionsAndFavorites() {
    _clear(_favoritesKey);
    _clear(_sectionsKey);
    _clear(_languagesKey);
  }

  void setCustomSectionMode(bool value) {
    _set(_customSectionMode, value);
  }

  bool getCustomSectionMode() => _get(_customSectionMode);

  Iterable<String> getFavoriteLectures() {
    final result = <String>[];
    final data = _getList(_favoritesKey);

    if (data.isNotEmpty) {
      result.addAll(Iterable.castFrom<dynamic, String>(data));
    }

    return result;
  }

  Iterable<String> getSections() {
    final result = <String>[];
    final data = _getList(_sectionsKey);

    if (data.isNotEmpty) {
      result.addAll(Iterable.castFrom<dynamic, String>(data));
    }

    return result;
  }

  void removeFavoriteLecture(String lectureId) => _removeFromList(_favoritesKey, lectureId);

  void setSections(Iterable<String> sectionIds) => _set(_sectionsKey, sectionIds);

  void setLanguages(Iterable<LanguageType> languages) => _set(_languagesKey, languages);

  void _addToList(String key, dynamic value) {
    final data = Iterable.castFrom(_getList(key)).toList();

    if (!data.contains(value)) {
      _set(key, data..add(value));
    }
  }

  void _clear(String key) {
    window.localStorage.remove(key);
  }

  dynamic _get(String key) {
    final value = window.localStorage[key];
    return (value?.isNotEmpty ?? false) ? jsonDecode(value) : null;
  }

  Iterable<dynamic> _getList(String key) {
    final data = _get(key);

    if (data != null && data is Iterable) {
      return data;
    }

    return [];
  }

  void _removeFromList(String key, dynamic value) {
    final data = _get(key) ?? <String>[];
    _set(key, data..remove(value));
  }

  void _set(String key, dynamic value) {
    window.localStorage[key] = jsonEncode(value);
  }
}
