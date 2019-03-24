import 'dart:async';

import 'package:codefest/src/redux/actions/change_lecture_favorite_action.dart';
import 'package:codefest/src/redux/actions/change_lecture_like_action.dart';
import 'package:codefest/src/redux/actions/change_selected_sections_action.dart';
import 'package:codefest/src/redux/actions/init_action.dart';
import 'package:codefest/src/redux/actions/load_data_error_action.dart';
import 'package:codefest/src/redux/actions/load_data_start_action.dart';
import 'package:codefest/src/redux/actions/load_data_success_action.dart';
import 'package:codefest/src/redux/actions/load_user_data_action.dart';
import 'package:codefest/src/redux/actions/load_user_data_from_storage_action.dart';
import 'package:codefest/src/redux/actions/load_user_data_success_action.dart';
import 'package:codefest/src/redux/actions/update_user_data_action.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:codefest/src/services/data_loader.dart';
import 'package:codefest/src/services/storage_service.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class Effects {
  final DataLoader _dataLoader;
  final StorageService _storageService;

  Effects(this._dataLoader, this._storageService);

  Epic<CodefestState> getEffects() {
    final streams = [
      _onInit,
      _onLoadData,
      _onLoadUserData,
      _onLoadUserDataFromStorage,
      _onChangeLectureLike,
      _onChangeLectureFavorite,
      _onChangeSelectedSections,
      _onUpdateUserData,
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

        if (user.isAuthorized) {
          await _dataLoader.updateUser(
              sectionIds: action.sectionIds, favoriteLectureIds: user.favoriteLectureIds.toList());
        } else {
          _storageService.setSections(action.sectionIds);
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
        } catch (e) {
          yield LoadDataErrorAction();
        }
      });

  Stream<Object> _onLoadUserData(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<LoadUserDataAction>()).asyncExpand((_) async* {
        try {
          final data = await _dataLoader.getUser();

          yield LoadUserDataSuccessAction(
            favoriteLectureIds: data.favoriteLecturesIds,
            likedLectureIds: data.likedLecturesIds,
            selectedSectionIds: data.sectionIds,
            displayName: data.displayName,
            avatarPath: data.avatar,
          );
        } catch (e) {
          yield LoadDataErrorAction();
        }
      });

  Stream<Object> _onLoadUserDataFromStorage(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<LoadUserDataFromStorageAction>()).asyncExpand((_) async* {
        try {
          final sectionIds = _storageService.getSections();
          final favoriteLectureIds = _storageService.getFavoriteLectures();

          yield LoadUserDataSuccessAction(
            favoriteLectureIds: favoriteLectureIds,
            selectedSectionIds: sectionIds,
          );
        } catch (e) {
          yield LoadDataErrorAction();
        }
      });

  Stream<Object> _onUpdateUserData(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<UpdateUserDataAction>()).asyncExpand((action) async* {
        try {
          final data = await _dataLoader.getUser();

          final storageFavoriteLectureIds = _storageService.getFavoriteLectures();
          final storageSectionIds = _storageService.getSections();

          final favoriteLectureIds = (storageFavoriteLectureIds.isNotEmpty && data.favoriteLecturesIds.isEmpty)
              ? storageFavoriteLectureIds
              : data.favoriteLecturesIds.toList();
          final sectionIds =
              (storageSectionIds.isNotEmpty && data.sectionIds.isEmpty) ? storageSectionIds : data.sectionIds.toList();

          if (favoriteLectureIds != data.favoriteLecturesIds || sectionIds != data.sectionIds) {
            await _dataLoader.updateUser(sectionIds: sectionIds, favoriteLectureIds: favoriteLectureIds);
            _storageService.clearSectionsAndFavorites();
          }

          yield LoadUserDataSuccessAction(
            favoriteLectureIds: favoriteLectureIds,
            selectedSectionIds: sectionIds,
            likedLectureIds: data.likedLecturesIds,
            displayName: data.displayName,
            avatarPath: data.avatar,
          );
        } catch (e) {
          yield LoadDataErrorAction();
        }
      });
}
