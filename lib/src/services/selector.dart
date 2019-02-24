import 'package:codefest/src/models/codefest_state.dart';

class Selector {
  bool isReady(CodefestState state) => state.isReady;
}
