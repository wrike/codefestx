import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/models/location.dart';

part 'codefest_state.g.dart';

abstract class CodefestState implements Built<CodefestState, CodefestStateBuilder> {

  factory CodefestState([void updates(CodefestStateBuilder b)]) = _$CodefestState;

  CodefestState._();

  BuiltList<Lecture> get lectures;

  BuiltList<Location> get locations;

  bool get isReady;
}
