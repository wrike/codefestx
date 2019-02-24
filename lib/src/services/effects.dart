import 'dart:async';

import 'package:codefest/src/actions/init_action.dart';
import 'package:codefest/src/actions/load_program_action.dart';
import 'package:codefest/src/models/codefest_state.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class Effects {
  Epic<CodefestState> getEffects() {
    final streams = [
      _onInit,
      _onLoadProgram,
    ];

    return combineEpics<CodefestState>(streams);
  }

  Stream<Object> _onInit(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions)
          .ofType(new TypeToken<InitAction>())
          .asyncExpand((_) async* {
            yield LoadProgramAction();
          });

  Stream<Object> _onLoadProgram(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions)
          .ofType(new TypeToken<LoadProgramAction>())
          .asyncExpand((_) async* {
            print('it`s work!');
          });
}
