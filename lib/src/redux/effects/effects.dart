import 'dart:async';
import 'dart:html';

import 'package:codefest/src/redux/actions/authorize_action.dart';
import 'package:codefest/src/redux/actions/create_post_action.dart';
import 'package:codefest/src/redux/actions/delete_post_action.dart';
import 'package:codefest/src/redux/actions/load_data_error_action.dart';
import 'package:codefest/src/redux/actions/load_data_start_action.dart';
import 'package:codefest/src/redux/actions/load_data_success_action.dart';
import 'package:codefest/src/redux/actions/load_talks_action.dart';
import 'package:codefest/src/redux/actions/loaded_talks_action.dart';
import 'package:codefest/src/redux/actions/set_scroll_top_action.dart';
import 'package:codefest/src/models/user.dart';
import 'package:codefest/src/redux/actions/actions.dart';
import 'package:codefest/src/redux/actions/effects/actions.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:codefest/src/services/auth_service.dart';
import 'package:codefest/src/services/auth_store.dart';
import 'package:codefest/src/services/data_loader.dart';
import 'package:codefest/src/services/storage_service.dart';
import 'package:codefest/src/services/talks_service.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class Effects {
  final DataLoader _dataLoader;
  final AuthStore _authStore;
  final StorageService _storageService;
  final TalksService _talkService;
  final AuthService _authService;

  Effects(
    this._talkService,
    this._dataLoader,
    this._storageService,
    this._authStore,
    this._authService,
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
      _onLoadLectureTalks,
      _onCreateNewPost,
      _onDeletePost,
    ];

    return combineEpics<CodefestState>(streams);
  }

  Stream<Object> _onDeletePost(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<DeletePostAction>()).asyncExpand((action) async* {
        await _talkService.deletePost(action.postId);
      });

  Stream<Object> _onCreateNewPost(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<CreatePostAction>()).asyncExpand((action) async* {
        await _talkService.createPost(action.lectureId, action.text, action.replyTo);
      });

  Stream<Object> _onLoadLectureTalks(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<LoadTalksAction>()).asyncExpand((action) async* {
        final talks = await _talkService.getPosts(action.lectureId);
        yield LoadedTalksAction(talks.toList(growable: false));
      });

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
          if (!_authStore.isAuth) {
            await _authService.createUser();
          }
          User data;
            try {
              data = await _dataLoader.getUser();
            } catch (e) {
              _authService.logout();
            }

            if (data != null) {
              yield AuthorizeAction();

              yield SetUserDataAction(
                favoriteLectureIds: data.favoriteLecturesIds,
                likedLectureIds: data.likedLecturesIds,
                selectedSectionIds: data.sectionIds,
                displayName: data.displayName,
                avatarPath: data.avatar,
                isCustomSectionMode: data.isCustomSectionMode,
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
        yield SetSelectedSectionsAction(
          sectionIds: action.sectionIds,
          isCustomSectionMode: action.isCustomSectionMode,
          languages: action.languages,
        );

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
          _storageService.setLanguages(action.languages);
        }
      });
}
