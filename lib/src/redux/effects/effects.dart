import 'dart:async';
import 'dart:html';

import 'package:codefest/src/redux/actions/actions.dart';
import 'package:codefest/src/redux/actions/effects/actions.dart';
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
      _onUpdateLectureLike,
      _onUpdateLectureFavorite,
      _onUpdateSelectedSections,
      _onSyncUserData,
      _onScroll,
      _onScrollToCurrentTime,
    ];

    return combineEpics<CodefestState>(streams);
  }

  Stream<Object> _onInit(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<InitAction>()).asyncExpand((action) async* {
        if (!store.state.isLoaded || action.isReload) {
          yield LoadDataAction();
        }
      });

  Stream<Object> _onLoadData(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<LoadDataAction>()).asyncExpand((_) async* {
        yield LoadDataStartAction();

        try {
          final apiData = await Future.wait([
            _dataLoader.getLectures(),
            _dataLoader.getLocations(),
            _dataLoader.getSections(),
            _dataLoader.getSpeakers(),
          ]);

          yield SetDataAction(
            lectures: apiData[0],
            locations: apiData[1],
            sections: apiData[2],
            speakers: apiData[3],
          );

          yield LoadDataSuccessAction();
          yield ScrollToCurrentTimeAction();
        } catch (e) {
          print(e);
          yield LoadDataErrorAction();
        }
      });

  Stream<Object> _onLoadUserData(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<LoadUserDataAction>()).asyncExpand((_) async* {
        try {
          if (_authStore.isAuth) {
            final data = await _dataLoader.getUser();

            yield AuthorizeAction();

            yield SetUserDataAction(
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

            yield SetUserDataAction(
              favoriteLectureIds: favoriteLectureIds,
              selectedSectionIds: sectionIds,
              isCustomSectionMode: isCustomSectionMode,
            );
          }
        } catch (e) {
          yield LoadDataErrorAction();
        }
      });

  Stream<Object> _onScroll(Stream<Object> actions, EpicStore<CodefestState> store) => Observable(actions)
          .ofType(const TypeToken<OnScrollAction>())
          .debounce(Duration(seconds: 1))
          .asyncExpand((action) async* {
        yield SetScrollTopAction(scrollTop: action.scrollTop);
      });

  Stream<Object> _onScrollToCurrentTime(Stream<Object> actions, EpicStore<CodefestState> store) => Observable(actions)
          .ofType(const TypeToken<ScrollToCurrentTimeAction>())
          .delay(Duration(milliseconds: 0))
          .asyncExpand((action) async* {
        document.querySelector('#currentTime')?.scrollIntoView(ScrollAlignment.TOP);
      });

  Stream<Object> _onSyncUserData(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<SyncUserDataAction>()).asyncExpand((action) async* {
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

          yield SetUserDataAction(
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

  Stream<Object> _onUpdateLectureFavorite(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<UpdateLectureFavoriteAction>()).asyncExpand((action) async* {
        yield SetLectureFavoriteAction(lectureId: action.lectureId, isFavorite: action.isFavorite);

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

  Stream<Object> _onUpdateLectureLike(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<UpdateLectureLikeAction>()).asyncExpand((action) async* {
        yield SetLectureLikeAction(lectureId: action.lectureId, isLiked: action.isLiked);
        await _dataLoader.updateLectureLike(lectureId: action.lectureId, value: action.isLiked);
      });

  Stream<Object> _onUpdateSelectedSections(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<UpdateSelectedSectionsAction>()).asyncExpand((action) async* {
        yield SetSelectedSectionsAction(sectionIds: action.sectionIds, isCustomSectionMode: action.isCustomSectionMode);

        final user = store.state.user;
        final sectionIds = action.sectionIds;

        if (user.isAuthorized) {
          await _dataLoader.updateUser(
            sectionIds: sectionIds.toList(),
            favoriteLectureIds: user.favoriteLectureIds.toList(),
            isCustomSectionMode: action.isCustomSectionMode,
          );
        } else {
          _storageService.setSections(sectionIds.toList());
          _storageService.setCustomSectionMode(action.isCustomSectionMode);
        }
      });
}
