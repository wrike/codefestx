import 'package:codefest/src/models/user.dart';
import 'package:meta/meta.dart';

class LoadUserDataSuccessAction {
  final User user;

  LoadUserDataSuccessAction({
    @required this.user,
  });
}
