import 'dart:async';

import 'package:codefest/src/actions/init_action.dart';
import 'package:codefest/src/actions/load_program_start_action.dart';
import 'package:codefest/src/actions/load_program_success_action.dart';
import 'package:codefest/src/models/codefest_state.dart';
import 'package:codefest/src/services/data_loader.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class Effects {
  final DataLoader _dataLoader;

  Effects(this._dataLoader);

  Epic<CodefestState> getEffects() {
    final streams = [
      _onInit,
      _onLoadProgram,
    ];

    return combineEpics<CodefestState>(streams);
  }

  Stream<Object> _onInit(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(new TypeToken<InitAction>()).asyncExpand((_) async* {
        yield LoadProgramStartAction();
      });

  Stream<Object> _onLoadProgram(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(new TypeToken<LoadProgramStartAction>()).asyncExpand((_) async* {
        yield LoadProgramSuccessAction(
          lectures: _dataLoader.getLectures(),
          locations: await _dataLoader.getLocations(),
          speakers: await _dataLoader.getSpeakers(),
        );
      });
}
