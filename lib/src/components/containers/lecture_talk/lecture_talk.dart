import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/containers/lecture_talk/empty_state/talks_zero_state.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/components/layout/navigation_type.dart';
import 'package:codefest/src/components/loader/loader.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/components/ui/popularity_icon/popularity_icon.dart';
import 'package:codefest/src/components/ui/tabs/tabs.dart';
import 'package:codefest/src/components/ui/talk_post/talk_post_component.dart';
import 'package:codefest/src/components/ui/talk_post_input/talk_post_input_component.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/models/talk_post.dart';
import 'package:codefest/src/redux/actions/change_lecture_favorite_action.dart';
import 'package:codefest/src/redux/actions/change_lecture_like_action.dart';
import 'package:codefest/src/redux/actions/create_post_action.dart';
import 'package:codefest/src/redux/actions/delete_post_action.dart';
import 'package:codefest/src/redux/actions/init_action.dart';
import 'package:codefest/src/redux/selectors/selectors.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/redux/services/store_factory.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/services/auth_store.dart';

@Component(
  selector: 'lecture-talk',
  styleUrls: ['lecture_talk.css'],
  templateUrl: 'lecture_talk.html',
  directives: [
    NgIf,
    NgFor,
    ButtonComponent,
    TalkPostComponent,
    TalkPostInputComponent,
    TalksStateComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LectureTalkComponent extends StatefulComponent {
  final AuthStore _authStore;
  final Dispatcher _dispatcher;
  @HostBinding('class.messages')
  final bool isHostMarked = true;
  bool get canCreatePost => _authStore.isAuth;
  @ViewChild('input')
  TalkPostInputComponent input;

  @Input()
  Lecture lecture;
  @Input()
  List<TalkPost> posts;

  LectureTalkComponent(
      NgZone zone,
      ChangeDetectorRef cdr,
      StoreFactory storeFactory,
      this._dispatcher, this._authStore,
      ) : super(zone, cdr, storeFactory);

  String parentId;

  void onSend(String newText) {
    _dispatcher.dispatch(CreatePostAction(lecture.id, newText, parentId));
    parentId = null;
  }

  void onPostDelete(String postId) {
    _dispatcher.dispatch(DeletePostAction(postId, lecture.id));
  }

  void onPostReply(String postId) {
    parentId = postId;
    input.focus();
  }
}
