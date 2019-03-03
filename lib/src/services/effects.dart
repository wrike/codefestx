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
      Observable(actions).ofType(const TypeToken<InitAction>()).asyncExpand((_) async* {
        yield LoadProgramStartAction();
      });

  Stream<Object> _onLoadProgram(Stream<Object> actions, EpicStore<CodefestState> store) =>
      Observable(actions).ofType(const TypeToken<LoadProgramStartAction>()).asyncExpand((_) async* {
        final apiData = await Future.wait([
          _dataLoader.getLectures(),
          _dataLoader.getLocations(),
          _dataLoader.getSpeakers(),
        ]);
        yield LoadProgramSuccessAction(
          lectures: apiData[0],
          locations: apiData[1],
          speakers: apiData[2],
        );
      });
}
