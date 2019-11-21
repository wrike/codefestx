import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:codefest/src/services/auth_store.dart';
import 'package:codefest/src/services/intl_service.dart';

@Component(
  selector: 'talk-post-input',
  templateUrl: 'talk_post_input_component.html',
  styleUrls: [
    'talk_post_input_component.css',
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
  directives: [
    NgIf,
    NgModel,
    formDirectives,
    ButtonComponent,
  ],
  preserveWhitespace: false,
)
class TalkPostInputComponent {
  final AuthStore _authStore;
  final Router _router;

  bool get isAllowToSend => newPostText.length > 1 && newPostText.length <= 255;
  final _onSend = StreamController<String>();

  @HostBinding('class.message-send')
  final bool isHostMarked = true;

  @Input()
  CodefestState state;

  @ViewChild('input')
  DivElement input;

  @ViewChild('loginButton')
  ButtonComponent loginButton;

  @Output()
  Stream get onSend => _onSend.stream;

  String newPostText = '';

  bool get canCreatePost => _authStore.isAuth;

  String get userName => _authStore.userName;

  String get userAvatar => state.user.avatarPath;

  TalkPostInputComponent(this._authStore, this._router);

  void onInput() {
    newPostText = input.text;
  }

  void onPaste(ClipboardEvent event) {
    event.preventDefault();
    final text = event.clipboardData.getData('text/plain');
    document.execCommand("insertHTML", false, text);
  }

  void send() {
    if (isAllowToSend) {
      _onSend.add(input.text);
      input.text = '';
      newPostText = '';
    }
  }

  void focus() {
    if (canCreatePost) {
      input.focus();
    } else {
      loginButton.nativeElement.focus();
    }
  }

  void onLoginButtonClick() {
    // _router.navigateByUrl(RoutePaths.login.toUrl());
  }

  /// I18n
  String get discussionPlaceholder => IntlService.discussionPlaceholder();
}
