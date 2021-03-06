import 'dart:math';

import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/models/talk_post.dart';
import 'package:codefest/src/redux/actions/actions.dart';
import 'package:codefest/src/redux/actions/add_post_action.dart';
import 'package:codefest/src/redux/actions/authorize_action.dart';
import 'package:codefest/src/redux/actions/deleted_post_action.dart';
import 'package:codefest/src/redux/actions/effects/change_locale_action.dart';
import 'package:codefest/src/redux/actions/filter_lectures_action.dart';
import 'package:codefest/src/redux/actions/load_data_error_action.dart';
import 'package:codefest/src/redux/actions/load_data_start_action.dart';
import 'package:codefest/src/redux/actions/load_data_success_action.dart';
import 'package:codefest/src/redux/actions/load_talks_action.dart';
import 'package:codefest/src/redux/actions/loaded_talks_action.dart';
import 'package:codefest/src/redux/actions/new_version_action.dart';
import 'package:codefest/src/redux/actions/search_lectures_action.dart';
import 'package:codefest/src/redux/actions/set_scroll_top_action.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:redux/redux.dart';

class CodefestReducer {
  Reducer<CodefestState> _reducer;

  CodefestReducer() {
    _reducer = combineReducers<CodefestState>([
      TypedReducer<CodefestState, LoadDataStartAction>(_onStartLoading),
      TypedReducer<CodefestState, LoadDataSuccessAction>(_onLoadDataSuccess),
      TypedReducer<CodefestState, LoadDataErrorAction>(_onLoadDataError),
      TypedReducer<CodefestState, SetDataAction>(_onSetData),
      TypedReducer<CodefestState, SetUserDataAction>(_onSetUserData),
      TypedReducer<CodefestState, AuthorizeAction>(_onAuthorize),
      TypedReducer<CodefestState, SearchLecturesAction>(_onSearchLectures),
      TypedReducer<CodefestState, SetSelectedSectionsAction>(_onSetSelectedSections),
      TypedReducer<CodefestState, FilterLecturesAction>(_onFilterLectures),
      TypedReducer<CodefestState, SetSearchModeAction>(_onSetSearchMode),
      TypedReducer<CodefestState, SetLectureLikeAction>(_onSetLectureLike),
      TypedReducer<CodefestState, SetLectureFavoriteAction>(_onSetLectureFavorite),
      TypedReducer<CodefestState, NewVersionAction>(_onNewVersion),
      TypedReducer<CodefestState, SetScrollTopAction>(_setScrollTopAction),
      TypedReducer<CodefestState, LoadTalksAction>(_resetTalkPosts),
      TypedReducer<CodefestState, LoadedTalksAction>(_loadedTalkPosts),
      TypedReducer<CodefestState, AddPostAction>(_addPost),
      TypedReducer<CodefestState, DeletedPostAction>(_removePost),
      TypedReducer<CodefestState, ChangeLocaleAction>(_changeLocale),
    ]);
  }

  CodefestState getState(CodefestState state, Object action) => _reducer(state, action);

  int _getFigureNumber(String id) {
    final code = id.codeUnitAt(id.length - 1).toString();
    final n = int.tryParse(code[code.length - 1]) ?? 0;
    return (n * 1.5).floor();
  }

  CodefestState _onAuthorize(CodefestState state, AuthorizeAction action) => state.rebuild((b) {
        final user = state.user.rebuild((b) {
          b.isAuthorized = true;
        });

        b.user.replace(user);
      });

  CodefestState _onFilterLectures(CodefestState state, FilterLecturesAction action) => state.rebuild((b) {
        final user = state.user.rebuild((b) {
          b.filterType = action.filterType;
        });

        b.user.replace(user);
      });

  CodefestState _onLoadDataError(CodefestState state, LoadDataErrorAction action) => state.rebuild(
        (b) => b.isError = true,
      );

  CodefestState _onLoadDataSuccess(CodefestState state, LoadDataSuccessAction action) => state.rebuild(
        (b) => b
          ..isReady = true
          ..isLoaded = true,
      );

  CodefestState _onNewVersion(CodefestState state, NewVersionAction action) => state.rebuild(
        (b) => b.releaseNote = action.releaseNote,
      );

  CodefestState _onSearchLectures(CodefestState state, SearchLecturesAction action) => state.rebuild(
        (b) => b.user.update((u) => u.searchText = action.searchText),
      );

  CodefestState _onSetData(CodefestState state, SetDataAction action) => state.rebuild(
        (b) => b
          ..maxFavorites = action.lectures.map((l) => l.favoritesCount).reduce(max)
          ..speakers.replace(action.speakers)
          ..locations.replace(action.locations)
          ..sections.replace(action.sections)
          ..lectures.replace(
            action.lectures.map(
              (lecture) => Lecture(
                id: lecture.id,
                title: lecture.title,
                type: lecture.type,
                language: lecture.lang,
                description: lecture.description,
                startTime: DateTime.fromMillisecondsSinceEpoch(lecture.startTime, isUtc: true),
                duration: lecture.duration,
                location: action.locations.firstWhere((location) => location.id == lecture.locationId),
                section: action.sections.firstWhere((section) => section.id == lecture.sectionId),
                speakers: action.speakers.where((speaker) => lecture.speakerIds.contains(speaker.id)).toList(),
                isFavorite: lecture.isFavorite,
                isLiked: lecture.isLiked,
                likesCount: lecture.likesCount,
                favoritesCount: lecture.favoritesCount,
                figureNumber: _getFigureNumber(lecture.id),
              ),
            ),
          ),
      );

  CodefestState _onSetLectureFavorite(CodefestState state, SetLectureFavoriteAction action) => state.rebuild((b) {
        b.user.replace(state.user.rebuild((b) {
          if (action.isFavorite) {
            b.favoriteLectureIds.add(action.lectureId);
          } else {
            b.favoriteLectureIds.remove(action.lectureId);
          }
        }));
      });

  CodefestState _onSetLectureLike(CodefestState state, SetLectureLikeAction action) => state.rebuild((b) {
        b.user.replace(state.user.rebuild((b) {
          if (action.isLiked) {
            b.likedLectureIds.add(action.lectureId);
          } else {
            b.likedLectureIds.remove(action.lectureId);
          }
        }));
      });

  CodefestState _onSetSearchMode(CodefestState state, SetSearchModeAction action) => state.rebuild((b) {
        final user = state.user.rebuild((b) {
          b.isSearchMode = action.isSearchMode;

          if (!action.isSearchMode) {
            b.searchText = '';
          }
        });

        b.user.replace(user);
      });

  CodefestState _onSetSelectedSections(CodefestState state, SetSelectedSectionsAction action) => state.rebuild((b) {
        final user = state.user.rebuild((b) {
          b.selectedSectionIds.replace(action.sectionIds);
          b.selectedLanguages.replace(action.languages);
          b.isCustomSectionMode = action.isCustomSectionMode;
        });

        b.user.replace(user);
      });

  CodefestState _onSetUserData(CodefestState state, SetUserDataAction action) => state.rebuild((b) => b
    ..user.replace(state.user.rebuild((u) => u
      ..favoriteLectureIds.replace(action.favoriteLectureIds)
      ..selectedSectionIds.replace(action.selectedSectionIds)
      ..likedLectureIds.replace(action.likedLectureIds ?? state.user.likedLectureIds)
      ..displayName = action.displayName ?? state.user.displayName
      ..avatarPath = action.avatarPath ?? state.user.avatarPath
      ..isCustomSectionMode = action.isCustomSectionMode ?? state.user.isCustomSectionMode)));

  CodefestState _onStartLoading(CodefestState state, LoadDataStartAction action) =>
      state.rebuild((b) => b.isReady = false);

  CodefestState _setScrollTopAction(CodefestState state, SetScrollTopAction action) =>
      state.rebuild((b) => b.scrollTop = action.scrollTop);

  CodefestState _resetTalkPosts(CodefestState state, LoadTalksAction action) => state.rebuild((b) {
        if (state.currentLecture != action.lectureId) {
          b.talkPosts.replace([]);
        }
        b.currentLecture = action.lectureId;
      });

  TalkPost _formatPost(TalkPost post, List<TalkPost> allPosts) {
    if (post.replyId != null) {
      final replyPost = allPosts.firstWhere((x) => x.id == post.replyId, orElse: () => null);
      if (replyPost != null) {
        post.replyText = replyPost.text;
        post.replyName = replyPost.authorName;
      } else {
        post.replyName = 'Unknown author';
        post.replyText = 'Post has been deleted :(';
      }
    }
    return post;
  }

  CodefestState _loadedTalkPosts(CodefestState state, LoadedTalksAction action) => state.rebuild((b) {
        final posts = action.posts.map((p) {
          return _formatPost(p, action.posts);
        });
        b.talkPosts.replace(posts);
      });

  CodefestState _addPost(CodefestState state, AddPostAction action) => state.rebuild((b) {
        if (state.currentLecture == action.post.lectureId && !state.talkPosts.any((p) => p.id == action.post.id)) {
          final post = _formatPost(action.post, state.talkPosts.toList(growable: false));
          b.talkPosts.add(post);
        }
      });

  CodefestState _removePost(CodefestState state, DeletedPostAction action) => state.rebuild((b) {
        final isHasPost = state.talkPosts.any((p) => p.id == action.postId);
        if (isHasPost) {
          final newPosts = state.talkPosts.where((p) => p.id != action.postId).toList(growable: false);
          final filteredPosts = newPosts.map((p) {
            return _formatPost(p, newPosts);
          });
          b.talkPosts.replace(filteredPosts);
        }
      });

  CodefestState _changeLocale(CodefestState state, ChangeLocaleAction action) =>
      state.rebuild((b) => b.locale = action.locale);
}
