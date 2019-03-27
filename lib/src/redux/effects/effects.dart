import 'dart:async';
import 'dart:html';

import 'package:codefest/src/redux/actions/authorize_action.dart';
import 'package:codefest/src/redux/actions/change_lecture_favorite_action.dart';
import 'package:codefest/src/redux/actions/change_lecture_like_action.dart';
import 'package:codefest/src/redux/actions/change_selected_sections_action.dart';
import 'package:codefest/src/redux/actions/init_action.dart';
import 'package:codefest/src/redux/actions/load_data_error_action.dart';
import 'package:codefest/src/redux/actions/load_data_start_action.dart';
import 'package:codefest/src/redux/actions/load_data_success_action.dart';
import 'package:codefest/src/redux/actions/load_lectures_data_action.dart';
import 'package:codefest/src/redux/actions/load_user_data_action.dart';
import 'package:codefest/src/redux/actions/load_user_data_success_action.dart';
import 'package:codefest/src/redux/actions/on_scroll_action.dart';
import 'package:codefest/src/redux/actions/scroll_to_current_time_action.dart';
import 'package:codefest/src/redux/actions/set_scroll_top_action.dart';
import 'package:codefest/src/redux/actions/start_lectures_check_action.dart';
import 'package:codefest/src/redux/actions/update_user_data_action.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:codefest/src/services/auth_store.dart';
import 'package:codefest/src/services/data_loader.dart';
import 'package:codefest/src/services/storage_service.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class Effects {
  final DataLoader _dataLoader;
  final AuthStore _authStore;
  final StorageService _storageService;

  Effects(
    this._dataLoader,
    this._storageService,
    this._authStore,
  );

  Epic<CodefestState> getEffects() {
    final streams = [
      _onInit,
      _onLoadData,
      _onLoadUserData,
      _onChangeLectureLike,
      _onChangeLectureFavorite,
      _onChangeSelectedSections,
      _onUpdateUserData,
      _onScroll,
      _onScrollToCurrentTime,
      _onCheckLectures,
    ];

    return combineEpics<CodefestState>(streams);
  }

  Stream<Object> _onChangeLectureFavorite(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<ChangeLectureFavoriteAction>()).asyncExpand((action) async* {
        if (store.state.user.isAuthorized) {
          await _dataLoader.updateLectureFavorite(lectureId: action.lectureId, value: action.isFavorite);
        } else {
          if (action.isFavorite) {
            _storageService.addFavoriteLecture(action.lectureId);
          } else {
            _storageService.removeFavoriteLecture(action.lectureId);
          }
        }
      });

  Stream<Object> _onChangeLectureLike(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<ChangeLectureLikeAction>()).asyncExpand((action) async* {
        await _dataLoader.updateLectureLike(lectureId: action.lectureId, value: action.isLiked);
      });

  Stream<Object> _onChangeSelectedSections(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<ChangeSelectedSectionsAction>()).asyncExpand((action) async* {
        final user = store.state.user;
        final sectionIds = action.sectionIds.toList();

        if (user.isAuthorized) {
          await _dataLoader.updateUser(
            sectionIds: sectionIds,
            favoriteLectureIds: user.favoriteLectureIds.toList(),
            isCustomSectionMode: action.isCustomSectionMode,
          );
        } else {
          _storageService.setSections(sectionIds);
          _storageService.setCustomSectionMode(action.isCustomSectionMode);
        }
      });

  Stream<Object> _onInit(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<InitAction>()).asyncExpand((action) async* {
        if (!store.state.isLoaded || action.isReload) {
          yield LoadDataStartAction();
        }
      });

  Stream<Object> _onLoadData(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<LoadDataStartAction>()).asyncExpand((_) async* {
        try {
          final apiData = await Future.wait([
            _dataLoader.getLectures(),
            _dataLoader.getLocations(),
            _dataLoader.getSections(),
            _dataLoader.getSpeakers(),
          ]);

          yield LoadDataSuccessAction(
            lectures: apiData[0],
            locations: apiData[1],
            sections: apiData[2],
            speakers: apiData[3],
          );

          yield ScrollToCurrentTimeAction();
        } catch (e) {
          yield LoadDataErrorAction();
        }
      });

  Stream<Object> _onLoadUserData(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<LoadUserDataAction>()).asyncExpand((_) async* {
        try {
          if (_authStore.isAuth) {
            final data = await _dataLoader.getUser();

            yield AuthorizeAction();

            yield LoadUserDataSuccessAction(
              favoriteLectureIds: data.favoriteLecturesIds,
              likedLectureIds: data.likedLecturesIds,
              selectedSectionIds: data.sectionIds,
              displayName: data.displayName,
              avatarPath: data.avatar,
              isCustomSectionMode: data.isCustomSectionMode,
            );
          } else {
            final sectionIds = _storageService.getSections();
            final favoriteLectureIds = _storageService.getFavoriteLectures();
            final isCustomSectionMode = _storageService.getCustomSectionMode() ?? true;

            yield LoadUserDataSuccessAction(
              favoriteLectureIds: favoriteLectureIds,
              selectedSectionIds: sectionIds,
              isCustomSectionMode: isCustomSectionMode,
            );
          }
        } catch (e) {
          yield LoadDataErrorAction();
        }
      });

  Stream<Object> _onScroll(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions)
          .ofType(const TypeToken<OnScrollAction>())
          .debounce(Duration(seconds: 1))
          .asyncExpand((action) async* {
            yield SetScrollTopAction(scrollTop: action.scrollTop);
          });

  Stream<Object> _onScrollToCurrentTime(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions)
          .ofType(const TypeToken<ScrollToCurrentTimeAction>())
          .delay(Duration(milliseconds: 0))
          .asyncExpand((action) async* {
            document.querySelector('#currentTime')?.scrollIntoView(ScrollAlignment.TOP);
          });

  Stream<Object> _onUpdateUserData(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<UpdateUserDataAction>()).asyncExpand((action) async* {
        try {
          final data = await _dataLoader.getUser();

          final storageFavoriteLectureIds = _storageService.getFavoriteLectures();
          final storageSectionIds = _storageService.getSections();
          final storageCustomSectionMode = _storageService.getCustomSectionMode();

          final needUpdateFavoriteLectures = storageFavoriteLectureIds.isNotEmpty && data.favoriteLecturesIds.isEmpty;
          final needUpdateSections = storageSectionIds.isNotEmpty && data.sectionIds.isEmpty;
          final needUpdateCustomSectionMode = storageCustomSectionMode != null && !data.isCustomSectionMode;

          final favoriteLectureIds = needUpdateFavoriteLectures ? storageFavoriteLectureIds : data.favoriteLecturesIds;
          final sectionIds = needUpdateSections ? storageSectionIds : data.sectionIds;
          final isCustomSectionMode = needUpdateCustomSectionMode ? storageCustomSectionMode : data.isCustomSectionMode;

          if (needUpdateFavoriteLectures || needUpdateSections) {
            await _dataLoader.updateUser(
              sectionIds: sectionIds.toList(),
              favoriteLectureIds: favoriteLectureIds.toList(),
              isCustomSectionMode: isCustomSectionMode,
            );

            _storageService.clearSectionsAndFavorites();
          }

          yield LoadUserDataSuccessAction(
            favoriteLectureIds: favoriteLectureIds,
            selectedSectionIds: sectionIds,
            likedLectureIds: data.likedLecturesIds,
            displayName: data.displayName,
            avatarPath: data.avatar,
            isCustomSectionMode: isCustomSectionMode,
          );
        } catch (e) {
          yield LoadDataErrorAction();
        }
      });

  Stream<Object> _onCheckLectures(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<StartLecturesCheckAction>()).asyncExpand((action) async* {
        final newLectures = await _dataLoader.getLecturesLite();
        yield LoadLecturesDataAction(lectures: newLectures);
      });
}
