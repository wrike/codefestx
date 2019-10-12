import 'dart:async';

import 'package:angular/angular.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/models/talk_post.dart';
import 'package:codefest/src/redux/services/store_factory.dart';
import 'package:codefest/src/services/auth_store.dart';
import 'package:intl/intl.dart';

@Component(
  selector: 'talk-post',
  templateUrl: 'talk_post_component.html',
  styleUrls: ['talk_post_component.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  directives: [
    NgIf,
  ],
  preserveWhitespace: false,
)
class TalkPostComponent extends StatefulComponent {
  final dateFormat = DateFormat("dd MMM HH:mm");

  bool get replyBlockShown {
    print(post.replyId);
    return post.replyId != null;
  }

  final _onDelete = StreamController<String>();
  final _onReply = StreamController<String>();
  @HostBinding('class.message')
  final bool isHostMarked = true;

  @Output()
  Stream get onDelete => _onDelete.stream;

  @Output()
  Stream get onReply => _onReply.stream;

  @Input()
  TalkPost post;
  final AuthStore _authStore;

  TalkPostComponent(
    this._authStore,
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
  ) : super(zone, cdr, storeFactory);

  String getTime() {
    final date = DateTime.fromMillisecondsSinceEpoch(post.date, isUtc: false);
    return dateFormat.format(date);
  }

  void onPostDelete() {
    _onDelete.add(post.id);
  }

  void onPostReply() {
    _onReply.add(post.id);
  }

  bool get canDelete => post.authorId == _authStore.userId;

  bool get canReply => _authStore.isAuth;
}
