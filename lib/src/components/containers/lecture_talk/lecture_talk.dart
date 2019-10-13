import 'package:angular/angular.dart';
import 'package:codefest/src/components/containers/lecture_talk/empty_state/talks_zero_state.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/components/ui/talk_post/talk_post_component.dart';
import 'package:codefest/src/components/ui/talk_post_input/talk_post_input_component.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/models/talk_post.dart';
import 'package:codefest/src/redux/actions/create_post_action.dart';
import 'package:codefest/src/redux/actions/delete_post_action.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/redux/services/store_factory.dart';
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
    TalksEmptyComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LectureTalkComponent extends StatefulComponent {
  final AuthStore _authStore;
  final Dispatcher _dispatcher;

  @HostBinding('class.messages')
  final bool isHostMarked = true;
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
    this._dispatcher,
    this._authStore,
  ) : super(
          zone,
          cdr,
          storeFactory,
        );

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
